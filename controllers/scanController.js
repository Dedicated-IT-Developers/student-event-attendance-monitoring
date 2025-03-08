const db = require('../models/db');
const { activeAcadYear, activeSem } = require('../utils/utils');
const { Op } = require('sequelize');
const moment = require('moment');

/**
 * RFID Scanner Page
 * @param {*} req 
 * @param {*} res 
 */
const scanner = async (req, res) => {
    try {
        user = req.user;

        const acadYear = await activeAcadYear();
        const semester = await activeSem();

        // Fetch activities with proper ordering
        activities = await db.Activity.findAll({
            where: { 
                semester: semester, 
                acadYear: acadYear 
            },
            order: [
                ['createdAt', 'DESC'], // Order by creation date, newest first
                ['date', 'DESC']       // Then by activity date
            ]
        });
        
        // Handle query parameter case
        if (req.query.query) {
            const query = req.query.query;
        
            const profiles = await db.Student.findAll({
                where: { rfId: query },
                attributes: ['id', 'firstName', 'lastName', 'idNumber', 'email', 'photoUrl']
            });
            res.json(profiles);
            return; // Stop further execution so res.render is not called
        }

        // Get today's date at midnight for comparison
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        
        // Filter activities for today and future dates
        activities = activities.filter(({ date }) => {
            const activityDate = new Date(date);
            activityDate.setHours(0, 0, 0, 0);
            
            return activityDate.getTime() === today.getTime();
        });

        res.render('rfscanner', { 
            'title': 'Home', 
            'page_name': 'home', 
            'activities': activities,
            'user': user 
        });

    } catch (error) {
        console.error('Error in scanner:', error);
        res.status(500).send('Internal Server Error');
    }
}

const submit = async (req, res) => {
    try {
        const { id, ActivityId, timeRange } = req.body;
        const currentTime = moment().format('HH:mm:ss');

        // Find or create attendance record for today
        let [attendance, created] = await db.Attendance.findOrCreate({
            where: {
                StudentId: id,
                ActivityId: ActivityId,
                date: {
                    [Op.gte]: moment().startOf('day'),
                    [Op.lte]: moment().endOf('day')
                }
            },
            defaults: {
                date: moment().toDate(),
                [timeRange + 'Time']: currentTime
            }
        });

        if (!created) {
            // Update existing record
            await attendance.update({
                [timeRange + 'Time']: currentTime
            });
        }

        const timeLabels = {
            inAM: 'Morning Time-In',
            outAM: 'Morning Time-Out',
            inPM: 'Afternoon Time-In',
            outPM: 'Afternoon Time-Out'
        };

        res.json({
            success: true,
            attendance,
            message: `${timeLabels[timeRange]} recorded successfully`
        });

    } catch (error) {
        console.error('Error submitting attendance:', error);
        res.status(500).json({
            success: false,
            message: 'Error recording attendance: ' + error.message
        });
    }
};

const check = async (req, res) => {
    try {
        const { id, ActivityId } = req.body;

        // Check if activity exists
        const activity = await db.Activity.findByPk(ActivityId);
        if (!activity) {
            return res.json({
                canSubmit: false,
                withinTimeRange: false,
                message: 'No active event or activity yet!'
            });
        }

        const now = moment();
        const currentTime = now.format('HH:mm:ss');

        // Convert activity times to comparable format
        const convertTime = (timeStr) => {
            if (!timeStr) return null;
            return moment(timeStr, 'HH:mm:ss').format('HH:mm:ss');
        };

        const checkTimeRange = (current, start, end) => {
            if (!start || !end) return false;
            return moment(current, 'HH:mm:ss').isBetween(
                moment(start, 'HH:mm:ss'),
                moment(end, 'HH:mm:ss'),
                'minute',
                '[]'
            );
        };

        let timeRange = null;
        let rangeName = '';

        if (checkTimeRange(currentTime, activity.inAMStart, activity.inAMEnd)) {
            timeRange = 'inAM';
            rangeName = 'Morning Time-In';
        } else if (checkTimeRange(currentTime, activity.outAMStart, activity.outAMEnd)) {
            timeRange = 'outAM';
            rangeName = 'Morning Time-Out';
        } else if (checkTimeRange(currentTime, activity.inPMStart, activity.inPMEnd)) {
            timeRange = 'inPM';
            rangeName = 'Afternoon Time-In';
        } else if (checkTimeRange(currentTime, activity.outPMStart, activity.outPMEnd)) {
            timeRange = 'outPM';
            rangeName = 'Afternoon Time-Out';
        }

        if (!timeRange) {
            return res.json({
                canSubmit: false,
                withinTimeRange: false,
                message: 'Not within any valid time range'
            });
        }

        // Check existing attendance for today
        const existingAttendance = await db.Attendance.findOne({
            where: {
                StudentId: id,
                ActivityId: ActivityId,
                date: {
                    [Op.gte]: moment().startOf('day'),
                    [Op.lte]: moment().endOf('day')
                }
            }
        });

        // Determine if we can submit based on existing record and time range
        const canSubmit = !existingAttendance || 
                         (timeRange === 'outAM' && !existingAttendance?.outAMTime) ||
                         (timeRange === 'inPM' && !existingAttendance?.inPMTime) ||
                         (timeRange === 'outPM' && !existingAttendance?.outPMTime);

        res.json({
            canSubmit,
            withinTimeRange: true,
            timeRange,
            rangeName,
            message: canSubmit ? `Ready to record ${rangeName}` : `Already recorded for ${rangeName}`
        });

    } catch (error) {
        console.error('Error checking attendance:', error);
        res.status(500).json({ 
            error: 'Internal server error',
            message: error.message 
        });
    }
};

const remove = async (req, res) => {
    
    try {
        const { id, ActivityId } = req.body;
       // const rfId = req.query.rfId;

        const lastAttendance = await db.Attendance.findOne({
          where: { StudentId: id, ActivityId: ActivityId },
          order: [['createdAt', 'DESC']]
        });
    
        if (!lastAttendance) {
          return res.status(404).json({ error: 'Attendance record not found.' });
        }
    
        await lastAttendance.destroy();
        res.status(200).json({ message: 'Last attendance record deleted successfully.' });

    } catch (error) {
        res.status(500).json({ error: error.message });
    }
    
}

module.exports = {
    scanner,
    submit,
    remove,
    check
}
