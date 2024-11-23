const express = require('express');

const attendanceController = require('../controllers/attendanceController');
const { authenticateTokenUser } = require('../middlewares/jwt_verifier');

// express app
const router = express.Router();

router.get('/', authenticateTokenUser, attendanceController.index);

module.exports = router;

