const express = require('express');
const router = express.Router();

router.get('/health', (req, res) => {
    res.end();
})
  
router.get('/multiplier', (req, res) => {
    const result = parseInt(req.query.num1) * parseInt(req.query.num2);
    res.json({ result });
})
  
router.get('/divisor', (req, res) => {
    const result = parseInt(req.query.num1) / parseInt(req.query.num2);
    res.json({ result });
})

module.exports = router;