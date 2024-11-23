const express = require('express');

const homeController = require('../controllers/homeController');
const { authenticateTokenUser } = require('../middlewares/jwt_verifier');

// express app
const router = express.Router();

router.get('/', authenticateTokenUser, homeController.home_index);

module.exports = router;

