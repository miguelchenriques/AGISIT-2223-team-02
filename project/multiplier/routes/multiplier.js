const express = require('express');
const router = express.Router();
var MongoClient = require('mongodb').MongoClient;
var url = "mongodb://localhost:27017/";

router.get('/health', (req, res) => {
    res.end();
})
  
router.get('/multiplier', (req, res) => {
    const result = parseInt(req.query.num1) * parseInt(req.query.num2);
    insertInDB(num1=req.query.num1, num2=req.query.num2, operation='*', result);
    res.json({ result });
})
  
router.get('/divisor', (req, res) => {
    const result = parseInt(req.query.num1) / parseInt(req.query.num2);
    insertInDB(num1=req.query.num1, num2=req.query.num2, operation='/', result);
    res.json({ result });
})

function insertInDB(num1, num2, operation, result) {
    MongoClient.connect(url, function(err, db) {
    if (err) throw err;
    var dbo = db.db("calculator");
    if (!db.getCollection('history').exists()) db.createCollection("history")
    var myobj = { num1, num2, operation, result };
    dbo.collection("history").insertOne(myobj, function(err, res) {
        if (err) throw err;
        console.log("1 entry inserted");
        db.close();
    });
    });
}

module.exports = router;