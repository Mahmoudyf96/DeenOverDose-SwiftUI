//
//  QuizView.swift
//  DeenOD-App
//
//  Created by McMoodie on 2020-11-14.
//

import SwiftUI
import Firebase

extension Color {
    static let oldPrimaryColor = Color(UIColor.systemIndigo)
    static let quizAnswersColour = Color("quizTextColour")
    static let correctColour = Color("correctColour")
    static let incorrectColour = Color("incorrectColour")
    static let timesUpColour = Color("TimesUpColour")
}

struct QuizView: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @Binding var rootIsActive: Bool
    
    @State private var loadingAmount = 0.0
    
    @Binding var correct: Int
    @Binding var wrong: Int
    @Binding var answered: Int
    
    @Binding var bestScore: Int
    @State var quizPosition = 0
    @State var score = 0
    
    @State private var correctAnswer = false
    @State private var wrongAnswer = false
    
    @State private var correctAnswerOne = false
    @State private var correctAnswerTwo = false
    @State private var correctAnswerThree = false
    
    @State private var gameOver = false
    @State private var timesUp = false
    
    @State private var answerOneActive = false
    @State private var answerTwoActive = false
    @State private var answerThreeActive = false
    
    @StateObject var data = QuestionViewModel()
    @State var set: String = "trivia-endless"
    
    @State var timeRemaining = 15
    @State var introTime = 3
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Background()
                if gameOver {
                    ResultView(introTime: $introTime, timeRemaining: $timeRemaining, gameOver: $gameOver, shouldPopToRootView: $rootIsActive, correctAnswer: $correctAnswer, wrongAnswer: $wrongAnswer, correctAnswerOne: $correctAnswerOne, correctAnswerTwo: $correctAnswerTwo, correctAnswerThree: $correctAnswerThree, answerOneActive: $answerOneActive, answerTwoActive: $answerTwoActive, answerThreeActive: $answerThreeActive, score: $score, bestScore: $bestScore)
                } else if introTime > 0 {
                    Text("\(introTime)")
                        .kerning(-1)
                        .font(.custom("PressStart2P-Regular", size: geo.size.height / 12.0))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .onReceive(timer) { _ in
                            self.introTime -= 1
                        }
                } else if data.questions.isEmpty {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                        .scaleEffect(1.5, anchor: .center)
                } else {
                    VStack {
                        HStack {
                            Spacer()
                                .frame(width: geo.size.width / 2.8)
                            ZStack {
                                ZStack {
                                    Image("TimeKeeper")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: sizeClass == .compact ? geo.size.height / 12.0 : geo.size.height / 14.0)
                                    Text("\(timeRemaining - 3)")
                                        .kerning(-1)
                                        .font(.custom("DeenOD", size: geo.size.height / 24.0))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .onReceive(timer) { _ in
                                            if self.timeRemaining > 4 {
                                                self.timeRemaining -= 1
                                            } else if self.timeRemaining > 1 && self.timeRemaining <= 4 {
                                                self.timeRemaining -= 1
                                                checkForBest()
                                                if !correctAnswer && !wrongAnswer {
                                                    timesUp = true
                                                    if timesUpCheck(data.questions[quizPosition].correctAnswer, data.questions[quizPosition].answers[2]) {
                                                        correctAnswerThree = true
                                                        answerThreeActive = true
                                                    } else if timesUpCheck(data.questions[quizPosition].correctAnswer, data.questions[quizPosition].answers[1]) {
                                                        correctAnswerTwo = true
                                                        answerTwoActive = true
                                                    } else if timesUpCheck(data.questions[quizPosition].correctAnswer, data.questions[quizPosition].answers[0]) {
                                                        correctAnswerOne = true
                                                        answerOneActive = true
                                                    }
                                                } else if wrongAnswer {
                                                    if wrongAnswer(data.questions[quizPosition].correctAnswer, data.questions[quizPosition].answers[2]) {
                                                        correctAnswerThree = true
                                                        answerThreeActive = true
                                                    } else if wrongAnswer(data.questions[quizPosition].correctAnswer, data.questions[quizPosition].answers[1]) {
                                                        correctAnswerTwo = true
                                                        answerTwoActive = true
                                                    } else if wrongAnswer(data.questions[quizPosition].correctAnswer, data.questions[quizPosition].answers[0]) {
                                                        correctAnswerOne = true
                                                        answerOneActive = true
                                                    }
                                                }
                                            } else {
                                                if quizPosition == data.questions.count - 1 {
                                                    reset()
                                                    correctAnswerOne = false
                                                    correctAnswerTwo = false
                                                    correctAnswerThree = false
                                                } else if timesUp && wrongAnswer == false && correctAnswer == true {
                                                    reset()
                                                    correctAnswerOne = false
                                                    correctAnswerTwo = false
                                                    correctAnswerThree = false
                                                } else if wrongAnswer == true {
                                                    reset()
                                                } else {
                                                    nextQuestion()
                                                    correctAnswerOne = false
                                                    correctAnswerTwo = false
                                                    correctAnswerThree = false
                                                }
                                            }
                                        }
                                        .offset(y: sizeClass == .compact ? -geo.size.height / 165.0 : -geo.size.height / 185.0)
                                }
                                .opacity(correctAnswer ? 0.0 : (wrongAnswer ? 0.0 : (timesUp ? 0.0 : 1.0)))
                                Image(correctAnswer ? "Correct" : "Wrong")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: sizeClass == .compact ? geo.size.height / 12.0 : geo.size.height / 14.0)
                                    .opacity(timesUp && !wrongAnswer && correctAnswer ? 0.0 : (correctAnswer ? 1.0 : (wrongAnswer ? 1.0 : 0)))
                                Image("TimesUp")
                                    .frame(width: sizeClass == .compact ? 180 : 360, height: sizeClass == .compact ? 45 : 90)
                                    .opacity(timesUp ? 1.0 : 0.0)
                            }
                            .frame(width: sizeClass == .compact ? 85 : 120)
                            Spacer()
                                .frame(width: geo.size.width / 4.8)
                            Button(action: {
                                score = 0
                                rootIsActive = false
                            }) {
                                ExitButton()
                            }
                            Spacer()
                                .frame(width: geo.size.width / 10.0)
                        }
                        .padding(.top, geo.size.height / 8.0)
                        Spacer()
                            .frame(height: geo.size.height / 70.0)
                        Text(data.questions[quizPosition].question)
                            .font(.custom("Bungee-Regular", size: geo.size.height / 35.0))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .frame(width: geo.size.width / 1.15, height: geo.size.height / 3)
                        Spacer()
                            .frame(height: geo.size.height / 150.0)
                        VStack {
                            Button(action: {
                                if checkAnswer(data.questions[quizPosition].correctAnswer, data.questions[quizPosition].answers[0]) {
                                    correctAnswerOne = true
                                }
                                answerOneActive = true
                                timeRemaining = 4
                            }) {
                                ZStack (alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                    Image(correctAnswerOne && answerOneActive ? "correctMBButton" : (wrongAnswer && answerOneActive ? "wrongMBButton" : "mBButton"))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geo.size.width / 1.15)
                                    Text(data.questions[quizPosition].answers[0])
                                        .font(.custom("Bungee-Regular" , size: geo.size.height / 35.0))
                                        .foregroundColor(.quizAnswersColour)
                                        .frame(width: geo.size.width / 1.15)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            .padding(.bottom, 20.0)
                            .disabled(answerOneActive || answerTwoActive || answerThreeActive || timesUp)
                            Button(action: {
                                if checkAnswer(data.questions[quizPosition].correctAnswer, data.questions[quizPosition].answers[1]) {
                                    correctAnswerTwo = true
                                }
                                answerTwoActive = true
                                timeRemaining = 4
                            }) {
                                ZStack (alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                    Image(correctAnswerTwo && answerTwoActive ? "correctMBButton" : (wrongAnswer && answerTwoActive ? "wrongMBButton" : "mBButton"))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geo.size.width / 1.15)
                                    Text(data.questions[quizPosition].answers[1])
                                        .font(.custom("Bungee-Regular" , size: geo.size.height / 35.0))
                                        .foregroundColor(.quizAnswersColour)
                                        .frame(width: geo.size.width / 1.15)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            .padding(.bottom, 20.0)
                            .disabled(answerOneActive || answerTwoActive || answerThreeActive || timesUp)
                            Button(action: {
                                if checkAnswer(data.questions[quizPosition].correctAnswer, data.questions[quizPosition].answers[2]) {
                                    correctAnswerThree = true
                                }
                                answerThreeActive = true
                                timeRemaining = 4
                            }) {
                                ZStack (alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                    Image(correctAnswerThree && answerThreeActive ? "correctMBButton" : (wrongAnswer && answerThreeActive ? "wrongMBButton" : "mBButton"))
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: geo.size.width / 1.15)
                                    Text(data.questions[quizPosition].answers[2])
                                        .font(.custom("Bungee-Regular" , size: geo.size.height / 35.0))
                                        .foregroundColor(.quizAnswersColour)
                                        .frame(width: geo.size.width / 1.15)
                                        .multilineTextAlignment(.center)
                                }
                            }
                            .disabled(answerOneActive || answerTwoActive || answerThreeActive || timesUp)
                        }
                        Spacer()
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: {
            data.getQuestions()
        })
    }
    
    func nextQuestion() {
        timesUp = false
        wrongAnswer = false
        correctAnswer = false
        answerOneActive = false
        answerTwoActive = false
        answerThreeActive = false
        quizPosition += 1
        timeRemaining = 15
    }
    
    func reset() {
        gameOver = true
        timesUp = false
        wrongAnswer = false
        correctAnswer = false
        answerOneActive = false
        answerTwoActive = false
        answerThreeActive = false
        quizPosition = 0
    }
    
    func checkForBest() {
        if score > bestScore {
            bestScore = score
        }
    }
    
    func checkAnswer(_ cCA: String, _ sA: String) -> Bool {
        if sA == cCA {
            score += 1
            correct += 1
            answered += 1
            correctAnswer = true
            return true
        } else {
            wrong += 1
            answered += 1
            wrongAnswer = true
            return false
        }
    }
    
    func timesUpCheck(_ cCA: String, _ sA: String) -> Bool {
        if sA == cCA {
            correctAnswer = true
            return true
        } else {
            return false
        }
    }
    
    func wrongAnswer(_ cCA: String, _ sA: String) -> Bool {
        if sA == cCA {
            return true
        } else {
            return false
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    
    @State static var isActive: Bool = false
    @State static var bestScore: Int = 0
    
    @State static var correct = 0
    @State static var wrong = 0
    @State static var answered = 0
    
    @State static var set = "trivia-endless"
    
    static var previews: some View {
        QuizView(rootIsActive: $isActive, correct: $correct, wrong: $wrong, answered: $answered, bestScore: $bestScore)
    }
}
