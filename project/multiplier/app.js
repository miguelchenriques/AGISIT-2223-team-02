const express = require('express');

const multiplier = require('./routes/multiplier');
const cors = require('cors');

const app = express();
app.use(cors());

app.use(multiplier);

module.exports = { app };