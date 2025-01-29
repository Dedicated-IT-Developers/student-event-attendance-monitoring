const db = require('../models/db');

// Render the settings form
const renderSettingsForm = async (req, res) => {
  try {
    const setting = await db.Setting.findOne(); // Fetch the single setting row
    if (!setting) {
      return res.status(404).render('error', { message: 'No settings found.' });
    }
    res.render('settingsForm', 
        { 
            'setting': setting, 
            'title': 'Settings', 
            'page_name': 'settings',
            'errors'    : [] 
        });
  } catch (error) {
    res.status(500).render('error', { message: 'Error fetching setting.', error });
  }
};

// Handle form submission to update the setting
const updateSetting = async (req, res) => {
  try {
    const { activeSemester, activeAcadYear } = req.body;
    const setting = await db.Setting.findOne();

    if (!setting) {
      return res.status(404).render('error', { message: 'No settings found.' });
    }

    setting.activeSemester = activeSemester || setting.activeSemester;
    setting.activeAcadYear = activeAcadYear || setting.activeAcadYear;

    await setting.save();
    res.redirect('/settings'); // Redirect back to the form after update
  } catch (error) {
    res.status(500).render('error', { message: 'Error updating setting.', error });
  }
};

module.exports = {
  renderSettingsForm,
  updateSetting,
};
