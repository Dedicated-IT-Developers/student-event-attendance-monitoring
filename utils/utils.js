const db = require('../models/db');

// utils.js
async function activeSem() {
    try {
        const setting = await db.Setting.findOne();
        return setting.activeSemester;
    } catch (error) {
        throw new Error('Could not fetch active semester');
    }
}

async function activeAcadYear() {
    try {
        const setting = await db.Setting.findOne();
        return setting.activeAcadYear;
    } catch (error) {
        throw new Error('Could not fetch active semester');
    }
}


  module.exports = {
    activeSem,
    activeAcadYear
  };
  