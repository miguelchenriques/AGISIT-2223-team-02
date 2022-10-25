const express = require('express');
const createError = require('http-errors');

const multiplier = require('./routes/multiplier');

const app = express();

app.use(multiplier);


app.use((req, res, next) => {
    next(createError.NotFound());
    next();
});

module.exports = { app };