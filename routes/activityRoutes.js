const express = require('express');
const { body, validationResult } = require('express-validator');

const activityController = require('../controllers/activityController');
const { authenticateTokenUser } = require('../middlewares/jwt_verifier');

// express app
const router = express.Router();

router.get('/', authenticateTokenUser, activityController.index);
router.get('/new', authenticateTokenUser, activityController.new_activity);

const activityValidation = [
    body('activityName').notEmpty().withMessage('Activity name is required'),
    body('date').isDate().notEmpty().withMessage('Date is required'),
    body('semester').notEmpty().withMessage('Semester is required'),
    body('acadYear').notEmpty().withMessage('AY is required'),
]

router.post('/create', authenticateTokenUser, activityValidation, activityController.create);

module.exports = router;

