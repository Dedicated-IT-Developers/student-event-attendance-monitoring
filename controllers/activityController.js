const { body, validationResult } = require('express-validator');
const db = require('../models/db');
const { activeAcadYear, activeSem } = require('../utils/utils');
const { timeStrToStd } = require('../utils/datetime');

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

    user = req.user

    try {
        const { count, rows } = await db.Activity.findAndCountAll({
            where: { semester: semester, acadYear: acadYear },
            offset,
            limit
        });
        const totalPages = Math.ceil(count / pageSize);

        
        // convert time '13:20:00' into '1:20 PM'
        const timeFields = [
            'inAMStart', 'inAMEnd', 'outAMStart', 'outAMEnd',
            'inPMStart', 'inPMEnd', 'outPMStart', 'outPMEnd'
        ];
        for (const row of rows) {
            const act = row.dataValues

            for (const field of timeFields) {
                if (act[field]) act[field] = timeStrToStd(act[field])
                else act[field] = '0';
            }
        }

        res.render('activity', {
            'title': 'Activity', 
            'page_name': 'activities',
            'totalItems': count,
            'totalPages': totalPages,
            'currentPage': page,
            'activity': rows,
            'pageSize': pageSize,
            'user':user
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
    user = req.user
    res.render('activity_create', {
        'title'     : 'Create Activity', 
        'page_name' : 'activitycreate',
        'errors'    : [],
        'user'      :   user
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

        user = req.user

        if (!errors.isEmpty()) {
          return res.render('activity_create', {
            'errors'    : errors.array(),
            'activity'   : req.body,
            'title'     : 'Create Activity', 
            'page_name' : 'activitycreate',
            'user':user
          });
        }

        try {

            //console.log('Request Body:', req.body);
            //console.log('File:', req.file.path);

            const {
                activityName,
                date,
                inAMStart,
                inAMEnd,
                outAMStart,
                outAMEnd,
                inPMStart,
                inPMEnd,
                outPMStart,
                outPMEnd,
                semester,
                acadYear,
            } = req.body;
            console.log(typeof inAMStart, inAMStart);

            // Ensure all required fields are present
            if (!activityName || !date || !semester || !acadYear) {
                return res.status(400).json({ error: 'Missing required fields' });
            }

            const activity = await db.Activity.create({
				activityName: activityName,
				date: date,
				inAMStart: !inAMStart ? null : inAMStart,
				inAMEnd: !inAMEnd ? null : inAMEnd,
				outAMStart: !outAMStart ? null : outAMStart,
				outAMEnd: !outAMEnd ? null : outAMEnd,
				inPMStart: !inPMStart ? null : inPMStart,
				inPMEnd: !inPMEnd ? null : inPMEnd,
				outPMStart: !outPMStart ? null : outPMStart,
				outPMEnd: !outPMEnd ? null : outPMEnd,
				semester: semester,
				acadYear: acadYear,
			})
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
