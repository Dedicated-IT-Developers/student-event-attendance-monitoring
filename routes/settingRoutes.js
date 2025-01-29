const express = require('express');
const router = express.Router();
const settingController = require('../controllers/settingController'); // Adjust the path if needed

// Route to render the settings form
router.get('/', settingController.renderSettingsForm);

// Route to handle the form submission
router.post('/update', settingController.updateSetting);

module.exports = router;
