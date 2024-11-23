const { body, validationResult } = require('express-validator');
const db = require('../models/db');
const { activeAcadYear, activeSem } = require('../utils/utils');

/**
 * Render the Activity List Page
 * @param {*} req 
 * @param {*} res 
 */
const index = async (req, res) => {

    const acadYear = await activeAcadYear();
    const semester = await activeSem();

    const page = parseInt(req.query.page) || 1;
    const pageSize = parseInt(req.query.pageSize) || 10;

    const offset = (page - 1) * pageSize;
    const limit = pageSize;

    try {
        const { count, rows } = await db.Activity.findAndCountAll({
            where: { semester: semester, acadYear: acadYear },
            offset,
            limit
        });
        const totalPages = Math.ceil(count / pageSize);

        res.render('activity', {
            'title': 'Activity', 
            'page_name': 'activities',
            'totalItems': count,
            'totalPages': totalPages,
            'currentPage': page,
            'activity': rows,
            'pageSize': pageSize,
        });
    } catch (error) {
        res.status(400).json({ error: error.message });
    }
}

/**
 * Create Activity Form
 * @param {*} req 
 * @param {*} res 
 */
const new_activity = async (req, res) => {
    res.render('activity_create', {
        'title'     : 'Create Activity', 
        'page_name' : 'activitycreate',
        'errors'    : []
    });
};

/**
 * Submit Activity
 * @param {*} req 
 * @param {*} res 
 * @returns 
 */
const create = async (req, res) => {

        const errors = validationResult(req);

        if (!errors.isEmpty()) {
          return res.render('activity_create', {
            'errors'    : errors.array(),
            'activity'   : req.body,
            'title'     : 'Create Activity', 
            'page_name' : 'activitycreate',
          });
        }

        try {

            //console.log('Request Body:', req.body);
            //console.log('File:', req.file.path);

            const { activityName, date, semester, acadYear } = req.body;

            
            // Ensure all required fields are present
            if (!activityName || !date || !semester || !acadYear) {
                return res.status(400).json({ error: 'Missing required fields' });
            }

            const activity = await db.Activity.create({
                activityName : activityName,
                date : date,
                semester : semester,
                acadYear : acadYear
            });
            res.redirect('/activities');

        } catch (error) {
            res.status(400).json({ error: error.message });
        }
    };

module.exports = {
    index,
    create,
    new_activity
}
