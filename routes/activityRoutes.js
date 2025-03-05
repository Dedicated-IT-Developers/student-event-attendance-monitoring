const express = require('express');
const { body, validationResult } = require('express-validator');

const activityController = require('../controllers/activityController');
const { authenticateTokenUser } = require('../middlewares/jwt_verifier');
const { timeStrToSec } = require('../utils/datetime');

// express app
const router = express.Router();

router.get('/', authenticateTokenUser, activityController.index);
router.get('/new', authenticateTokenUser, activityController.new_activity);

const activityValidation = [
	body("activityName").notEmpty().withMessage("Activity name is required"),
	body("date").isDate().notEmpty().withMessage("Date is required"),

	// AM session validation
    body("inAMStart").custom((value, { req }) => {
		if (value && !req.body.inAMEnd) {
			throw new Error("In AM Start requires In AM End.")
        }
        else if (value && (!req.body.outAMStart || !req.body.outAMEnd)) {
            throw new Error("In AM requires an Out AM.")
        }
        else if (value && timeStrToSec(value) > timeStrToSec(req.body.inAMEnd)) {
            throw new Error("In AM Start cannot be after In AM End.")
        }
        
		return true
	}),
	body("inAMEnd").custom((value, { req }) => {
		if (value && !req.body.inAMStart) {
			throw new Error("In AM End requires In AM Start.")
        }
        else if (value && (!req.body.outAMStart || !req.body.outAMEnd)) {
			throw new Error("In AM requires an Out AM.")
        }
        else if (value && timeStrToSec(value) < timeStrToSec(req.body.inAMStart)) {
            throw new Error("In AM End cannot be before In AM Start.")
        }
		return true
	}),

	body("outAMStart").custom((value, { req }) => {
		if (value && !req.body.outAMEnd) {
			throw new Error("Out AM Start requires Out AM End.")
        }
        else if (value && (!req.body.outAMStart || !req.body.outAMEnd)) {
			throw new Error("Out AM requires an In AM.")
        }
        else if (value && timeStrToSec(value) > timeStrToSec(req.body.outAMEnd)) {
            throw new Error("Out AM Start cannot be after Out AM End.")
        }
        else if (value && timeStrToSec(value) < timeStrToSec(req.body.inAMEnd)) {
            throw new Error("Out AM Start cannot be before In AM End.")
        }
		return true
	}),
	body("outAMEnd").custom((value, { req }) => {
		if (value && !req.body.outAMStart) {
			throw new Error("Out AM End requires Out AM Start.")
        }
        else if (value && (!req.body.inAMStart || !req.body.inAMEnd)) {
            throw new Error("Out AM requires an In AM.")
        }
        else if (value && timeStrToSec(value) < timeStrToSec(req.body.outAMStart)) {
            throw new Error("Out AM End cannot be before Out AM Start.")
        }
		return true
	}),

	// PM session validation
	body("inPMStart").custom((value, { req }) => {
		if (value && !req.body.inPMEnd) {
			throw new Error("In PM Start requires In PM End.")
        }
        else if (value && (!req.body.outPMStart || !req.body.outPMEnd)) {
			throw new Error("In PM requires an Out PM.")
        }
        else if (value && timeStrToSec(value) > timeStrToSec(req.body.inPMEnd)) {
            throw new Error("In PM Start cannot be after In PM End.")
        }
        else if (value && timeStrToSec(value) < timeStrToSec(req.body.outAMEnd)) {
            throw new Error("In PM Start cannot be before Out AM End.")
        }
		return true
	}),
	body("inPMEnd").custom((value, { req }) => {
		if (value && !req.body.inPMStart) {
			throw new Error("In PM End requires In PM Start.")
        }
        else if (value && (!req.body.outPMStart || !req.body.outPMEnd)) {
			throw new Error("In PM requires an Out PM.")
        }
        else if (value && timeStrToSec(value) < timeStrToSec(req.body.inPMStart)) {
            throw new Error("In PM End cannot be before In PM Start.")
        }
		return true
	}),

	body("outPMStart").custom((value, { req }) => {
		if (value && !req.body.outPMEnd) {
			throw new Error("Out PM Start requires Out PM End.")
        }
        else if (value && (!req.body.inPMStart || !req.body.inPMEnd)) {
			throw new Error("Out PM requires an In PM.")
        }
        else if (value && timeStrToSec(value) > timeStrToSec(req.body.outPMEnd)) {
            throw new Error("Out PM Start cannot be after Out PM End.")
        }
        else if (value && timeStrToSec(value) < timeStrToSec(req.body.inPMEnd)) {
            throw new Error("Out PM Start cannot be before In PM End.")
        }
		return true
	}),
	body("outPMEnd").custom((value, { req }) => {
		if (value && !req.body.outPMStart) {
			throw new Error("Out PM End requires Out PM Start.")
        }
        else if (value && (!req.body.inPMStart || !req.body.inPMEnd)) {
			throw new Error("Out PM requires an In PM.")
        }
        else if (value && timeStrToSec(value) <= timeStrToSec(req.body.outPMStart)) {
            throw new Error("Out PM End cannot be before Out PM Start.")
        }
		return true
	}),

	body("semester").notEmpty().withMessage("Semester is required"),
	body("acadYear").notEmpty().withMessage("AY is required"),
]

router.post('/create', authenticateTokenUser, activityValidation, activityController.create);

module.exports = router;

