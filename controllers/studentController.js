const { body, check, validationResult } = require('express-validator');
const db = require('../models/db');
const { activeAcadYear, activeSem } = require('../utils/utils');
const ExcelJS = require('exceljs');
const path = require('path');
const fs = require('fs');

/**
 * Student List Page
 * @param {*} req 
 * @param {*} res 
 */
const index = async (req, res) => {

    const acadYear = await activeAcadYear();
    const semester = await activeSem();

    const page = parseInt(req.query.page) || 1;
    const pageSize = parseInt(req.query.pageSize) || 10;
    const idNumber = req.query.idNumber || ''; // Get idNumber from query params

    const offset = (page - 1) * pageSize;
    const limit = pageSize;

   // Create where clause for the Student model
    const studentWhereClause = {};
    // If idNumber is provided, add it to the Student where clause
    if (idNumber) {
        studentWhereClause.idNumber = idNumber;
    }

    const enrolledWhereClause = {
        semester: semester,
        acadYear: acadYear
    };

    try {
        const { count, rows } = await db.Student.findAndCountAll({
            where: studentWhereClause,  // Filters for Student model
            include: [
                {
                    model: db.Enrolled,     // Join with Enrolled model
                    where: enrolledWhereClause,  // Filters for Enrolled model
                    //required: false  // Optional: Set to false if you want students without enrollments to also be included
                }
            ],
            offset,
            limit
        });
        const totalPages = Math.ceil(count / pageSize);

        user = req.user

        res.render('students', {
            'title': 'Student', 
            'page_name': 'students',
            'totalItems': count,
            'totalPages': totalPages,
            'currentPage': page,
            'students': rows,
            'pageSize': pageSize,
            'idNumber': idNumber,
            'user':user
        });
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
}

/**
 * Render Create Student Form
 * @param {*} req 
 * @param {*} res 
 */
const new_student = async (req, res) => {
    user = req.user
    res.render('student_create', {
        'title'     : 'Create Student', 
        'page_name' : 'studentcreate',
        'errors'    : [],
        'user':user
    });
};

/**
 * Submit student form
 * @param {*} req 
 * @param {*} res 
 * @returns 
 */
const createStudent = async (req, res) => {

    user = req.user

        const errors = validationResult(req);
        if (!errors.isEmpty()) {
          return res.render('student_create', {
            'errors'    : errors.array(),
            'student'   : req.body,
            'title'     : 'Create Student', 
            'page_name' : 'studentcreate',
            'user':user
          });
        }

        try {

            //console.log('Request Body:', req.body);
            //console.log('File:', req.file.path);

            const { firstName, middleName, lastName, email, idNumber, rfId, yearLevel, section } = req.body;

            //const photoUrl = req.file ? req.file.path : null;
            const photoUrl = req.file ? `/upload/${req.file.filename}` : null;

            // Ensure all required fields are present
            if (!firstName || !email || !idNumber || !rfId) {
                return res.status(400).json({ error: 'Missing required fields' });
            }

            const student = await db.Student.create({
                yearLevel : yearLevel, 
                section : section, 
                firstName : firstName,
                middleName : middleName,
                lastName : lastName,
                email : email,
                idNumber : idNumber,
                rfId : rfId,
                photoUrl : photoUrl}
            );
            res.redirect('/students');

        } catch (error) {
            res.status(400).json({ error: error.message });
        }
    };

/**
 * Get student by ID and render edit form
 * @param {*} req 
 * @param {*} res 
 */
const getEditForm = async (req, res) => {
    try {
        const student = await db.Student.findOne({
            where: {
                id: req.params.id
            }
        });
        user = req.user
        //.findById(req.params.id);
        res.render('student_edit', { 
            'student' : student, 
            'title' : 'Edit Student', 
            'page_name' : 'studentedit', 
            errors: null ,
            'user':user
        });
    } catch (error) {
        console.log(error);
        res.redirect('/students');
    }
};

/**
 * Update Student (form and submit)
 * @param {*} req 
 * @param {*} res 
 * @returns 
 */
const updateStudent = async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        const student = await db.Student.findOne({
            where: {
                id: req.params.id
            }
        });
        user = req.user
        //.findById(req.params.id);
        return res.render('student_edit', { 
            'student' : student, 
            'title' : 'Edit Student', 
            'page_name' : 'studentedit', 
            errors: null ,
            'user':user
        });
    }

    
    try {
        const student = await db.Student.findOne({
            where: {
                id: req.params.id
            }
        });

        student.firstName = req.body.firstName;
        student.middleName = req.body.middleName;
        student.lastName = req.body.lastName;
        student.email = req.body.email;
        student.idNumber = req.body.idNumber;
        student.yearLevel = req.body.yearLevel;
        student.section = req.body.section;
        student.rfId = req.body.rfId;

        if (req.file) {
            student.photoUrl = req.file.filename;
        }

        await student.save();
        req.flash('info', "Success!");
        res.redirect('/students/edit/' + req.params.id);
    } catch (error) {
        console.log(error);
        res.redirect('/students');
    }
};


/**
 * Student import form
 * @param {*} req 
 * @param {*} res 
 */
const getImportForm = (req, res) => {
    user = req.user
    res.render('student_import', { message: null, 'title'     : 'Import Student', 
        'page_name' : 'studentimport','user':user});
};

/**
 * Import students from Excel file
 * @param {*} req 
 * @param {*} res 
 * @returns 
 */
const importStudents = async (req, res) => {
    user = req.user
    if (!req.file) {
        return res.render('student_import', { message: 'No file uploaded' , 'title'     : 'Import Student', 
            'page_name' : 'studentimport','user':user});
    }

    const filePath = path.join(__dirname, '..', 'uploads', req.file.filename);

    let savedCount = 0;
    let totalCount = 0;

    try {
        const workbook = new ExcelJS.Workbook();
        await workbook.xlsx.readFile(filePath);

        const worksheet = workbook.getWorksheet(1);
        totalCount = worksheet.rowCount - 1; // Exclude header row

        for (let i = 2; i <= worksheet.rowCount; i++) {
            const row = worksheet.getRow(i);

            var year_level;
            if(row.getCell(6).value == "First Year"){
                year_level = 1;
            }else if(row.getCell(6).value == "Second Year"){
                year_level = 2;
            }else if(row.getCell(6).value == "Third Year"){
                year_level = 3;
            }else if(row.getCell(6).value == "Fourth Year"){
                year_level = 4;
            }

            let section = '';
            try {
                section = row.getCell(8).value.split('-')[1];
            } catch (error) {
                section = ''; // Fallback if an error occurs
            }

            const studentData = {
                idNumber: row.getCell(1).value,
                firstName: row.getCell(3).value,
                middleName: row.getCell(4).value,
                lastName: row.getCell(2).value,
                email: row.getCell(5).value,
                yearLevel: year_level,
                section: section
            };

            try {
                let student = await db.Student.findOne({
                    where: { idNumber: studentData.idNumber }
                });

                if (student) {
                    student = Object.assign(student, studentData);
                    await student.save();
                } else {
                    //student = new db.Student(studentData);
                    const student = await db.Student.create(studentData);
                }
                //await student.save();
                savedCount++;
            } catch (error) {
                console.log(`Error saving student with ID ${studentData.idNumber}: ${error.message}`);
            }
        }

        res.render('student_import', { message: `${savedCount} of ${totalCount} rows saved/updated successfully` , 'title'     : 'Import Student', 
            'page_name' : 'studentimport','user':user});
            
    } catch (error) {
        console.error('Error reading Excel file:', error.message);
        res.render('student_import', { message: 'Error reading Excel file' , 'title'     : 'Import Student', 
            'page_name' : 'studentimport','user':user});
    } finally {
        // Clean up the uploaded file
        fs.unlink(filePath, (err) => {
            if (err) {
                console.error('Error deleting uploaded file:', err.message);
            }
        });
    }
};


/**
 * Get student by ID and render edit form
 * @param {*} req 
 * @param {*} res 
 */
const getEnrollmentForm = async (req, res) => {
    try {
        user = req.user
        const student = await db.Student.findOne({
            where: {
                id: req.params.id
            }
        });
        //.findById(req.params.id);
        res.render('student_enrollment', { 
            'student' : student, 
            'title' : 'Edit Student', 
            'page_name' : 'studentedit', 
            errors: null ,
            'user':user
        });
    } catch (error) {
        console.log(error);
        res.redirect('/students');
    }
};

/**
 * Update Student (form and submit)
 * @param {*} req 
 * @param {*} res 
 * @returns 
 */
const enrollStudent = async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        const student = await db.Student.findOne({
            where: {
                id: req.params.id
            }
        });
        user = req.user
        //.findById(req.params.id);
        return res.render('student_enrollment', { 
            'student' : student, 
            'title' : 'Edit Student', 
            'page_name' : 'studentedit', 
            errors: null ,
            'user':user
        });
    }

    
    try {
        const student = await db.Student.findOne({
            where: {
                id: req.params.id
            }
        });

        student.firstName = req.body.firstName;
        student.middleName = req.body.middleName;
        student.lastName = req.body.lastName;
        student.email = req.body.email;
        student.idNumber = req.body.idNumber;
        student.yearLevel = req.body.yearLevel;
        student.section = req.body.section;
        student.rfId = req.body.rfId;

        if (req.file) {
            student.photoUrl = req.file.filename;
        }

        await student.save();
        req.flash('info', "Success!");
        res.redirect('/students/edit/' + req.params.id);
    } catch (error) {
        console.log(error);
        res.redirect('/students');
    }
};


module.exports = {
    index,
    createStudent,
    new_student,
    getEditForm,
    updateStudent,
    getImportForm,
    importStudents,
    getEnrollmentForm,
    enrollStudent
}
