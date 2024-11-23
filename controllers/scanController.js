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

    const acadYear = await activeAcadYear();
    const semester = await activeSem();

    activities = await db.Activity.findAll({
        where: { semester: semester, acadYear: acadYear }
    });
    
    // Check if the query parameter is present
    if (req.query.query) {
        const query = req.query.query;

        const profiles = await db.Student.findAll(
            { 
                where: { rfId: query, semester: semester, acadYear: acadYear } ,
                attributes: ['id', 'firstName', 'lastName', 'idNumber', 'email', 'photoUrl']
            }
        );
        res.json(profiles);
    }

    res.render('rfscanner',  { 'title': 'Home', 'page_name': 'home', 'activities' : activities });
}

const submit = async (req, res) => {
    
    const { id, ActivityId } = req.body;
    const attendance = await db.Attendance.create({ StudentId: id, ActivityId: ActivityId });
    res.json({ success: true, attendance });
    
}

const check = async (req, res) => {
    
    try {
        const { id, ActivityId } = req.body;

        // Get the current time and subtract 30 minutes to get the cutoff time
        const cutoffTime = moment().subtract(30, 'minutes').toDate();

        // Find attendance records for the given ID within the last 30 minutes
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
    
}

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
