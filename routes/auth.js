const router = require('express').Router();
const User = require('../models/User');

const { validatedUserRegistration, validatedUserLogin } = require('../validation');
const bcrypt = require('bcryptjs');

const jwt = require('jsonwebtoken');

//Register
router.post('/register', async (req,res) => {
    
    //Validate data before creating a user
    const {error} = validatedUserRegistration(req.body);
    if(error) return res.status(400).send(error.details[0].message);

    //Check for duplicate usernames & emails
    const emailExists = await User.findOne({email: req.body.email});
    const userExists = await User.findOne({name: req.body.name});
    if(emailExists) return res.status(400).send('Email already exists')
    if(userExists) return res.status(400).send('Username already exists')

    //Hash the passwords
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(req.body.password, salt);

    //Create a new user
    const user = new User ({
        name: req.body.name,
        email: req.body.email,
        password: hashedPassword
    });

    try {
        const savedUser = await user.save();
        res.send({user: user._id});
    } catch(err) {
        res.status(400).send(err);
    }
});

//Login
router.post('/login', async (req,res) => {

    //Validate data before creating a user
    const { error } = validatedUserLogin(req.body);
    if (error) return res.status(400).send(error.details[0].message);

    //Checking for the existing email
    const user = await User.findOne({email: req.body.email});
    if(!user) return res.status(400).send('Email does not exist')

    //Checking if the password is correct
    const validPass = await bcrypt.compare(req.body.password, user.password)
    if(!validPass) return res.status(400).send('Invalid Password')

    //Token is created and sent to user
    const token = jwt.sign({ _id: user._id }, process.env.TOKEN_SECRET);
    res.header('auth-token', token).send(token);
});

module.exports = router;