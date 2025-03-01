const db = require('../models/db');
const { activeAcadYear, activeSem } = require('../utils/utils');
const { Op } = require('sequelize');

const moment = require('moment-timezone');

/**
 * RFID Scanner Page
 * @param {*} req 
 * @param {*} res 
 */
// const scanner = async (req, res) => {

//     user = req.user

//     const acadYear = await activeAcadYear();
//     const semester = await activeSem();

//     activities = await db.Activity.findAll({
//         where: { semester: semester, acadYear: acadYear }
//     });
    
//     // Check if the query parameter is present
//     if (req.query.query) {
//         const query = req.query.query;

//         const profiles = await db.Student.findAll(
//             { 
//                 where: { rfId: query } ,
//                 //where: { rfId: query, semester: semester, acadYear: acadYear } ,
//                 attributes: ['id', 'firstName', 'lastName', 'idNumber', 'email', 'photoUrl']
//             }
//         );
//         res.json(profiles);
//     }

//     res.render('rfscanner',  { 'title': 'Home', 'page_name': 'home', 'activities' : activities,'user':user });
// }





const scanner = async (req, res) => {
    const user = req.user;
    const acadYear = await activeAcadYear();
    const semester = await activeSem();

    // Get the current time in Asia/Manila timezone
    const now = moment().tz('Asia/Manila');
    const startOfDay = now.clone().startOf('day').toDate();
    const endOfDay = now.clone().endOf('day').toDate();

    // Fetch active events for the current day and time
    const activities = await db.Activity.findAll({
        where: {
            semester: semester,
            acadYear: acadYear,
            date: { [Op.between]: [startOfDay, endOfDay] },
            startTime: { [Op.lte]: now.format('HH:mm:ss') }, // Use time comparison
            endTime: { [Op.gte]: now.format('HH:mm:ss') }
        }
    });

    // If no active events, render with a message
    if (activities.length === 0) {
        return res.render('rfscanner', {
            title: 'Home',
            page_name: 'home',
            activities: [],
            user: user,
            message: 'No active event for this day',
            moment: moment
        });
    }

    // If RFID query is present
    if (req.query.query) {
        const query = req.query.query;
        const profiles = await db.Student.findAll({
            where: { rfId: query },
            attributes: ['id', 'firstName', 'lastName', 'idNumber', 'email', 'photoUrl']
        });
        return res.json(profiles);
    }

    res.render('rfscanner', {
        title: 'Home',
        page_name: 'home',
        activities: activities,
        user: user,
        moment: moment
    });
};

// const submit = async (req, res) => {
    
//     const { id, ActivityId } = req.body;
//     const attendance = await db.Attendance.create({ StudentId: id, ActivityId: ActivityId });
//     res.json({ success: true, attendance });
    
// }

const submit = async (req, res) => {
    const { id, ActivityId } = req.body;
    
    // Fetch the activity details
    const activity = await db.Activity.findByPk(ActivityId);
    if (!activity) {
        return res.status(404).json({ error: 'Activity not found' });
    }
    
    // Check if the current time is within the scheduled start and end times
    const now = moment();
    if (now.isBefore(moment(activity.startTime)) || now.isAfter(moment(activity.endTime))) {
        return res.status(400).json({ error: 'Attendance not accepted: Not within scheduled time.' });
    }
    
    // Proceed with attendance creation if valid
    const attendance = await db.Attendance.create({ StudentId: id, ActivityId: ActivityId });
    res.json({ success: true, attendance });
};

// const check = async (req, res) => {
    
//     try {
//         const { id, ActivityId } = req.body;

//         // Get the current time and subtract 30 minutes to get the cutoff time
//         const cutoffTime = moment().subtract(30, 'minutes').toDate();

//         // Find attendance records for the given ID within the last 30 minutes
//         const recentAttendance = await db.Attendance.findOne({
//             where: {
//                 StudentId: id,
//                 ActivityId: ActivityId,
//                 createdAt: { [Op.gte]: cutoffTime }
//             }
//         });

//         if (recentAttendance) {
//             res.json({ canSubmit: false });
//         } else {
//             res.json({ canSubmit: true });
//         }
//     } catch (error) {
//         console.error('Error checking attendance:', error);
//         res.status(500).json({ error: 'Internal server error' });
//     }
    
// }
/**
 * Check Attendance
 * 2nd tap: returns canSubmit false if an attendance record exists in the last 30 minutes.
 */
const check = async (req, res) => {
    try {
        const { id, ActivityId } = req.body;
        // Set cutoff time (30 minutes ago)
        const cutoffTime = moment().subtract(30, 'minutes').toDate();

        const recentAttendance = await db.Attendance.findOne({
            where: {
                StudentId: id,
                ActivityId: ActivityId,
                createdAt: { [Op.gte]: cutoffTime }
            }
        });

        if (recentAttendance) {
            res.json({ canSubmit: false });
        } else {
            res.json({ canSubmit: true });
        }
    } catch (error) {
        console.error('Error checking attendance:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
};
// const remove = async (req, res) => {
    
//     try {
//         const { id, ActivityId } = req.body;
//        // const rfId = req.query.rfId;

//         const lastAttendance = await db.Attendance.findOne({
//           where: { StudentId: id, ActivityId: ActivityId },
//           order: [['createdAt', 'DESC']]
//         });
    
//         if (!lastAttendance) {
//           return res.status(404).json({ error: 'Attendance record not found.' });
//         }
    
//         await lastAttendance.destroy();
//         res.status(200).json({ message: 'Last attendance record deleted successfully.' });

//     } catch (error) {
//         res.status(500).json({ error: error.message });
//     }
    
// }

const remove = async (req, res) => {
    try {
        const { id, ActivityId } = req.body;

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
};


module.exports = {
    scanner,
    submit,
    remove,
    check
}
