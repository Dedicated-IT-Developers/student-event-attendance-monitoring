const db = require('../models/db');
const { Op } = require('sequelize');
const ExcelJS = require('exceljs');
const { activeAcadYear, activeSem } = require('../utils/utils');

/**
 * Attendance List with pagination and exporting via excel file
 * @param {*} req 
 * @param {*} res 
 */
const index = async (req, res) => {

  user = req.user

  const acadYear = await activeAcadYear();
  const semester = await activeSem();

  activities = await db.Activity.findAll({
      where: { semester: semester, acadYear: acadYear }
  });

  try {
    const page = parseInt(req.query.page) || 1;
    const limit = 10;
    const offset = (page - 1) * limit;
    const { startDate, endDate, export: exportFlag, ActivityId } = req.query;

    const where = {};
    if (startDate) where.date = { [db.Sequelize.Op.gte]: new Date(startDate) };
    if (endDate) where.date = { ...where.date, [db.Sequelize.Op.lte]: new Date(endDate) };
    if (ActivityId) where.ActivityId = ActivityId;

    if (exportFlag) {
      
      // Fetch all students
      // const students = await db.Student.findAll({
      //   order: [
      //     ['idNumber', 'ASC']
      //   ]
      // });

      // Fetch only students enrolled in the active semester and academic year
      const students = await db.Student.findAll({
        include: [
          {
            model: db.Enrolled,
            where: {
              semester: semester,
              acadYear: acadYear
            },
            required: true // Ensures only students with matching Enrolled records are fetched
          }
        ],
        order: [['idNumber', 'ASC']]
      });


      // Fetch all attendance records within the specified date range and activity
      const attendances = await db.Attendance.findAll({
        where,
        include: [{ model: db.Student }, { model: db.Activity }],
        order: [
          ['StudentId', 'ASC'],
          ['date', 'ASC']
        ]
      });

      // Create a map to collect all attendances per student
      const studentData = new Map();
      students.forEach((student) => {
        studentData.set(student.idNumber, {
          count: studentData.size + 1, // Assign a count
          idNumber: student.idNumber,
          firstName: student.firstName,
          lastName: student.lastName,
          email: student.email,
          yearLevel: student.yearLevel,
          section: student.section,
          activityName: 'N/A',
          dates: []
        });
      });

      var excelName = '';

      // Collect data
      attendances.forEach((attendance) => {
        const studentId = attendance.Student ? attendance.Student.idNumber : 'N/A';
        const dateStr = attendance.date.toLocaleString();

        if (!studentData.has(studentId)) {
          studentData.set(studentId, {
            count: studentData.size + 1, // Assign a count
            idNumber: studentId,
            firstName: attendance.Student ? attendance.Student.firstName : 'N/A',
            lastName: attendance.Student ? attendance.Student.lastName : 'N/A',
            email: attendance.Student ? attendance.Student.email : 'N/A',
            yearLevel: attendance.Student ? attendance.Student.yearLevel : 'N/A',
            section: attendance.Student ? attendance.Student.section : 'N/A',
            activityName: attendance.Activity ? attendance.Activity.activityName : 'N/A',
            dates: []
          });
        }

        const studentRecord = studentData.get(studentId);
        studentRecord.activityName = attendance.Activity ? attendance.Activity.activityName : 'N/A';
        studentRecord.dates.push(dateStr); // Append date to the list of dates

        if (attendance.Activity) excelName = attendance.Activity.activityName;

      });

      // Determine the maximum number of dates for headers
      const maxDates = Math.max(...Array.from(studentData.values()).map(data => data.dates.length));
      const headers = [
        '#',
        'ID Number',
        'First Name',
        'Last Name',
        'Email',
        'Year Level',
        'Section',
        'Activity',
        ...Array.from({ length: maxDates }, (_, i) => `Date ${i + 1}`), // Generate date columns
        'Absences' // Add header for absences
      ];

      // Set up workbook and worksheet
      const workbook = new ExcelJS.Workbook();
      const worksheet = workbook.addWorksheet('Attendances');

      // Set worksheet columns
      worksheet.columns = headers.map(header => ({
        header: header,
        key: header.toLowerCase().replace(/\s+/g, '_'), // Create keys for easy access
        width: 20
      }));

      // Add rows to the worksheet
      studentData.forEach((data) => {
        const row = [
          data.count,
          data.idNumber,
          data.firstName,
          data.lastName,
          data.email,
          data.yearLevel,
          data.section,
          data.activityName,
          ...data.dates // Append dates
        ];

        // Add empty cells for absent dates
        const emptyCells = Array(maxDates - data.dates.length).fill('');
        row.push(...emptyCells);

        // Calculate the number of blank dates
        const absences = maxDates - data.dates.length;
        row.push(absences); // Append absences to the row

        worksheet.addRow(row);
      });

      // Save workbook to file
      // if (exportFlag) {
      //   workbook.xlsx.writeFile(excelName + ' - attendances.xlsx')
      //     .then(() => {
      //       console.log('Workbook saved!');
      //     })
      //     .catch(err => {
      //       console.error('Error saving workbook:', err);
      //     });
      // }

      // Send workbook as a response
      res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
      res.setHeader('Content-Disposition', 'attachment; filename=' + excelName + ' - attendances.xlsx');

      await workbook.xlsx.write(res);
      res.end();

    } else {

      // Handle displaying the filtered and paginated data
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
            startDate : startDate,
            endDate : endDate,
            ActivityId: ActivityId,
            'title': 'Attendance', 'page_name': 'attendance', 'activities' : activities,'user':user
        });

    }


  } catch (error) {
      //res.status(500).json({ error: 'An error occurred while fetching attendances.' });
      res.status(500).json({ error: error.message });
  }
    
}

module.exports = {
    index
}
