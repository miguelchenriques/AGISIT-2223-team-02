const express = require('express');

const multiplier = require('./routes/multiplier');

const app = express();

app.use(multiplier);

module.exports = { app };