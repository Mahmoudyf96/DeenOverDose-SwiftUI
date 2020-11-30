const mongoose = require('mongoose');

const quizSchema = mongoose.Schema({
    id: {
        type: String,
        required: true
    },
    question: {
        type: String,
        required: true
    },
    answers: [{
        type: String,
        required: true
    }],
    correctAnswer: {
        type: String,
        required: true
    },
    topic: {
        type: String,
        required: true
    },
    difficulty: {
        type: String,
        required: true
    },
    reference: {
        type: String,
        required: true
    }
});

module.exports = mongoose.model('Quiz', quizSchema);