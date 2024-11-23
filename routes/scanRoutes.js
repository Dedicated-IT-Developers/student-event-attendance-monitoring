const express = require('express');

const scanController = require('../controllers/scanController');
const { authenticateTokenUser } = require('../middlewares/jwt_verifier');

// express app
const router = express.Router();

router.get('/', authenticateTokenUser, scanController.scanner);
router.post('/submit', authenticateTokenUser, scanController.submit);
router.post('/check', authenticateTokenUser, scanController.check);
router.post('/remove', authenticateTokenUser, scanController.remove);

module.exports = router;

