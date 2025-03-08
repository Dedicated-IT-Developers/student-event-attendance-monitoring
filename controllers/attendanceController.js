const db = require('../models/db');
const { Op } = require('sequelize');
const ExcelJS = require('exceljs');
const moment = require('moment'); // Add this line
const { activeAcadYear, activeSem } = require('../utils/utils');

const index = async (req, res) => {
    try {
        user = req.user;
        const acadYear = await activeAcadYear();
        const semester = await activeSem();
        activities = await db.Activity.findAll({
            where: { semester: semester, acadYear: acadYear }
        });

        const page = parseInt(req.query.page) || 1;
        const limit = 10;
        const offset = (page - 1) * limit;
        const { startDate, endDate, export: exportFlag, ActivityId } = req.query;

        // Fix date range filtering
        const where = {};
        if (startDate || endDate) {
            where.date = {};
            
            if (startDate) {
                const start = moment(startDate).startOf('day').toDate();
                where.date[Op.gte] = start;
            }
            
            if (endDate) {
                const end = moment(endDate).endOf('day').toDate();
                where.date[Op.lte] = end;
            }
        }
        
        if (ActivityId) {
            where.ActivityId = ActivityId;
        }

        if (exportFlag) {
      
            const students = await db.Student.findAll({
                include: [
                    {
                        model: db.Enrolled,
                        where: {
                            semester: semester,
                            acadYear: acadYear
                        },
                        required: true
                    }
                ],
                order: [['idNumber', 'ASC']]
            });

            const attendances = await db.Attendance.findAll({
                where,
                include: [{ model: db.Student }, { model: db.Activity }],
                order: [
                    ['StudentId', 'ASC'],
                    ['date', 'ASC']
                ]
            });

            const studentData = new Map();
            students.forEach((student) => {
                studentData.set(student.idNumber, {
                    count: studentData.size + 1,
                    idNumber: student.idNumber,
                    firstName: student.firstName,
                    lastName: student.lastName,
                    email: student.email,
                    yearLevel: student.yearLevel,
                    section: student.section,
                    activityName: 'N/A',
                    inAMTime: '-',
                    outAMTime: '-',
                    inPMTime: '-',
                    outPMTime: '-',
                    dates: [],
                    times: []
                });
            });

            var excelName = '';

            // Get activity time ranges
            const activity = await db.Activity.findByPk(ActivityId);
            const activeTimeRanges = [];
            
            if (activity) {
                if (activity.inAMStart && activity.inAMEnd) activeTimeRanges.push('AM In');
                if (activity.outAMStart && activity.outAMEnd) activeTimeRanges.push('AM Out');
                if (activity.inPMStart && activity.inPMEnd) activeTimeRanges.push('PM In');
                if (activity.outPMStart && activity.outPMEnd) activeTimeRanges.push('PM Out');
            }

            const totalRequiredAttendances = activeTimeRanges.length;

            attendances.forEach((attendance) => {
                const studentId = attendance.Student ? attendance.Student.idNumber : 'N/A';
                const dateStr = attendance.date.toLocaleString();

                if (!studentData.has(studentId)) {
                    studentData.set(studentId, {
                        count: studentData.size + 1,
                        idNumber: studentId,
                        firstName: attendance.Student ? attendance.Student.firstName : 'N/A',
                        lastName: attendance.Student ? attendance.Student.lastName : 'N/A',
                        email: attendance.Student ? attendance.Student.email : 'N/A',
                        yearLevel: attendance.Student ? attendance.Student.yearLevel : 'N/A',
                        section: attendance.Student ? attendance.Student.section : 'N/A',
                        activityName: attendance.Activity ? attendance.Activity.activityName : 'N/A',
                        inAMTime: '-',
                        outAMTime: '-',
                        inPMTime: '-',
                        outPMTime: '-',
                        dates: [],
                        times: []
                    });
                }

                const studentRecord = studentData.get(studentId);
                studentRecord.activityName = attendance.Activity ? attendance.Activity.activityName : 'N/A';
                studentRecord.dates.push(dateStr);

                const formatTime = (time) => time ? moment(time, 'HH:mm:ss').format('hh:mm A') : '-';
                
                studentRecord.times.push({
                    inAM: formatTime(attendance.inAMTime),
                    outAM: formatTime(attendance.outAMTime),
                    inPM: formatTime(attendance.inPMTime),
                    outPM: formatTime(attendance.outPMTime)
                });

                // Count present time ranges
                let presentCount = 0;
                if (activeTimeRanges.includes('AM In') && attendance.inAMTime) presentCount++;
                if (activeTimeRanges.includes('AM Out') && attendance.outAMTime) presentCount++;
                if (activeTimeRanges.includes('PM In') && attendance.inPMTime) presentCount++;
                if (activeTimeRanges.includes('PM Out') && attendance.outPMTime) presentCount++;

                studentRecord.presentCount = (studentRecord.presentCount || 0) + presentCount;
            });

            const maxDates = Math.max(...Array.from(studentData.values()).map(data => data.dates.length));
            const baseHeaders = [
                '#',
                'ID Number',
                'First Name',
                'Last Name',
                'Email',
                'Year Level',
                'Section',
                'Activity'
            ];

            const dateTimeHeaders = [];
            for (let i = 1; i <= maxDates; i++) {
                dateTimeHeaders.push(
                    `Date ${i}`,
                    `AM In ${i}`,
                    `AM Out ${i}`,
                    `PM In ${i}`,
                    `PM Out ${i}`
                );
            }

            const headers = [...baseHeaders, ...dateTimeHeaders, 'Absences'];

            const workbook = new ExcelJS.Workbook();
            const worksheet = workbook.addWorksheet('Attendances');

            worksheet.columns = headers.map(header => ({
                header,
                key: header.toLowerCase().replace(/\s+/g, '_'),
                width: 15
            }));

            studentData.forEach((data) => {
                const baseData = [
                    data.count,
                    data.idNumber,
                    data.firstName,
                    data.lastName,
                    data.email,
                    data.yearLevel,
                    data.section,
                    data.activityName
                ];

                const timeData = [];
                for (let i = 0; i < maxDates; i++) {
                    timeData.push(
                        data.dates[i] || '',
                        activeTimeRanges.includes('AM In') ? (data.times[i]?.inAM || '-') : 'N/A',
                        activeTimeRanges.includes('AM Out') ? (data.times[i]?.outAM || '-') : 'N/A',
                        activeTimeRanges.includes('PM In') ? (data.times[i]?.inPM || '-') : 'N/A',
                        activeTimeRanges.includes('PM Out') ? (data.times[i]?.outPM || '-') : 'N/A'
                    );
                }

                // Calculate absences based on required attendances
                const totalRequired = totalRequiredAttendances * maxDates;
                const absences = totalRequired - (data.presentCount || 0);

                worksheet.addRow([...baseData, ...timeData, absences]);
            });

            // Add summary to worksheet
            worksheet.addRow([]);  // Empty row
            worksheet.addRow(['Time Ranges Required:']);
            activeTimeRanges.forEach(range => {
                worksheet.addRow([`- ${range}`]);
            });
            worksheet.addRow([`Total Required Attendances per Day: ${totalRequiredAttendances}`]);

            worksheet.getRow(1).font = { bold: true };
            worksheet.getRow(1).alignment = { vertical: 'middle', horizontal: 'center' };

            worksheet.eachRow({ includeEmpty: true }, row => {
                row.eachCell({ includeEmpty: true }, cell => {
                    cell.border = {
                        top: { style: 'thin' },
                        left: { style: 'thin' },
                        bottom: { style: 'thin' },
                        right: { style: 'thin' }
                    };
                    cell.alignment = { vertical: 'middle', horizontal: 'center' };
                });
            });

            res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
            res.setHeader('Content-Disposition', 'attachment; filename=' + excelName + ' - attendances.xlsx');

            await workbook.xlsx.write(res);
            res.end();

        } else {

            const { count, rows } = await db.Attendance.findAndCountAll({
                where,
                include: [{ model: db.Student }, { model: db.Activity }],
                order: [
                    ['StudentId', 'ASC'],
                    ['date', 'ASC']
                ],
                limit,
                offset
            });

            const totalPages = Math.ceil(count / limit);

            res.render('attendance', {
                attendances: rows,
                currentPage: page,
                totalPages: totalPages,
                startDate: startDate,
                endDate: endDate,
                ActivityId: ActivityId,
                title: 'Attendance',
                page_name: 'attendance',
                activities: activities,
                user: user
            });
        }

    } catch (error) {
        console.error('Error in attendance:', error);
        res.status(500).json({ error: error.message });
    }
};

module.exports = {
    index
}
