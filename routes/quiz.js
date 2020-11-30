const express = require('express');
const router = express.Router();

//Import Model & Verification
const Quiz = require('../models/Quiz');
const verify = require('./verifyToken');

//GET BACK ALL THE QUIZZES FROM DB
router.get('/', async (req,res) => {

    //You have access to the user and their Data
    //res.send(req.user)
    //User.findbyOne({ _id: req.user })
    
    try {
        const quiz = await Quiz.find();
        res.json(quiz);
    } catch(err) {
        res.json({message: err});
    }

});

//SUBMIT THE QUIZ TO DB
router.post('/', async (req, res) => {
    const quiz = new Quiz({
        id: req.body.id,
        question: req.body.question,
        answers: req.body.answers,
        correctAnswer: req.body.correctAnswer,
        topic: req.body.topic,
        difficulty: req.body.difficulty,
        reference: req.body.reference
    });

    try {
        const savedQuiz = await quiz.save();
        res.json(savedQuiz);
    } catch(err) {
        res.json({message: err})
    }
})

//GET BACK A SPECIFIC QUIZ
router.get('/:quizId', async (req,res) => {
    try {
        const quiz = await Quiz.findById(req.params.quizId);
        res.json(quiz);
    } catch(err) {
        res.json({message: err})
    }
});

//DELETE SPECIFIC QUIZ
router.delete('/:quizId', async (req,res) => {
    try {
        const removedQuiz = await Quiz.findOneAndDelete({_id: req.params.quizId});
        res.json(removedQuiz);
    } catch(err) {
        res.json({message: err});
    }
})

//UPDATE A SPECIFIC QUIZ
router.patch('/:quizId', async (req, res) => {
    try {
        const updateQuiz = await Quiz.updateOne(
                { _id: req.params.quizId },
                { $set: { question: req.body.question } }
            );
        res.json(updateQuiz);
    } catch(err) {
        res.json({message: err});
    }
})

module.exports = router;