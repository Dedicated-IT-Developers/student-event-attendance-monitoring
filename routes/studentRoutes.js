const express = require('express');
const multer = require('multer');
const { body, validationResult } = require('express-validator');

const studentController = require('../controllers/studentController');
const { authenticateTokenUser } = require('../middlewares/jwt_verifier');

// express app
const router = express.Router();

// Configure multer for file uploads
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
      cb(null, 'uploads/'); // Define the upload directory
    },
    filename: (req, file, cb) => {
      cb(null, `${Date.now()}_${file.originalname}`);
    }
});
const upload = multer({ storage });

// view student
router.get('/', authenticateTokenUser, studentController.index);
// Create a new student
router.get('/new', authenticateTokenUser, studentController.new_student);

// Validation rules
const studentValidators = [
  body('firstName').notEmpty().trim().escape().withMessage('First Name is required'),
  body('lastName').notEmpty().trim().escape().withMessage('Last Name is required'),
  body('idNumber').notEmpty().trim().escape().withMessage('ID Number is required'),
  body('email').isEmail().normalizeEmail().withMessage('Invalid email address'),
  body('yearLevel').notEmpty().trim().escape().withMessage('Yearlevel is required'),
  body('section').notEmpty().trim().escape().withMessage('Section is required'),
  //body('password').isLength({ min: 8 }).withMessage('Password must be at least 8 characters long')
];

router.post('/create', authenticateTokenUser, upload.single('photo'), studentValidators, studentController.createStudent);

// Edit student form
router.get('/edit/:id', authenticateTokenUser, studentController.getEditForm);

// Update student
router.post('/update/:id', authenticateTokenUser, upload.single('photo'), studentValidators, studentController.updateStudent);


// Import students from Excel file
router.get('/import', authenticateTokenUser, studentController.getImportForm);
router.post('/import', authenticateTokenUser, upload.single('file'), studentController.importStudents);

module.exports = router;

