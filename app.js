const express = require('express');
const app = express();

const mongoose = require('mongoose');

const dotenv = require('dotenv');
dotenv.config();

//Import Routes
const quizRoute = require('./routes/quiz');
const authRoute = require('./routes/auth');


//MIDDLEWARES - Functions that execute when routes are being used
app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use('/api/quiz', quizRoute);
app.use('/api/user', authRoute);

//ROUTES - Areas in your server
app.get('/', (req,res) => {
    res.send('We are on home');
});

//Connect to DB
mongoose.connect(process.env.DB_CONNECTION, { useNewUrlParser: true, useUnifiedTopology: true }, () => {
    console.log('Connected to DB!');
});

//Start LISTENING - PORT(3000)
app.listen(3000, () => console.log('Server is listening...'));