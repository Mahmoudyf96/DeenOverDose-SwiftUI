//
//  QuizView.swift
//  DeenOD-App
//
//  Created by McMoodie on 2020-11-14.
//

import SwiftUI

extension Color {
    static let oldPrimaryColor = Color(UIColor.systemIndigo)
    static let quizAnswersColour = Color("quizTextColour")
    static let correctColour = Color("correctColour")
    static let incorrectColour = Color("incorrectColour")
}

struct QuizView: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @Binding var rootIsActive: Bool
    
    @State private var quizPosition = 0
    @State private var correctAnswer = false
    @State private var wrongAnswer = false
    
    @State private var gameOver = false
    @State private var timesUp = false
    
    @State private var answerOneActive = false
    @State private var answerTwoActive = false
    @State private var answerThreeActive = false
    
    @State var score = 0
    @Binding var bestScore: Int
    
    @State var timeRemaining = 15
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    GreenBackground()
                    if gameOver {
                        ResultView(timeRemaining: $timeRemaining, gameOver: $gameOver, shouldPopToRootView: $rootIsActive, score: $score, bestScore: $bestScore)
                    } else {
                        VStack {
                            HStack {
                                Spacer()
                                    .frame(width: geo.size.width / 2.8)
                                ZStack {
                                    HStack {
                                        Text(":")
                                            .kerning(-geo.size.height / 55.0)
                                            .font(.custom("PressStart2P-Regular", size: geo.size.height / 28.0))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                        Text("\(timeRemaining - 3)")
                                            .kerning(-1)
                                            .font(.custom("PressStart2P-Regular", size: geo.size.height / 28.0))
                                            .foregroundColor(.white)
                                            .multilineTextAlignment(.center)
                                            .onReceive(timer) { _ in
                                                if self.timeRemaining > 4 {
                                                    self.timeRemaining -= 1
                                                    checkForBest()
                                                } else if self.timeRemaining > 1 && self.timeRemaining <= 4 {
                                                    self.timeRemaining -= 1
                                                    checkForBest()
                                                    timesUp = true
                                                } else {
                                                    gameOver = true
                                                    timesUp = false
                                                    wrongAnswer = false
                                                    correctAnswer = false
                                                    answerOneActive = false
                                                    answerTwoActive = false
                                                    answerThreeActive = false
                                                }
                                            }
                                    }
                                    .opacity(correctAnswer ? 0.0 : (wrongAnswer ? 0.0 : (timesUp ? 0.0 : 1.0)))
                                    ZStack {
                                        Circle()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: sizeClass == .compact ? 55 : 80, height: sizeClass == .compact ? 25 : 40)
                                            .foregroundColor(correctAnswer ? .correctColour : .incorrectColour)
                                            .offset(x: sizeClass == .compact ? 7 : 20)
                                            .opacity(correctAnswer ? 0.8 : (wrongAnswer ? 0.8 : (timesUp && !correctAnswer && correctAnswer ? 1.0 : 0)))
                                        Image(systemName: correctAnswer ? "checkmark" : "xmark")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.white)
                                            .offset(x: sizeClass == .compact ? 7 : 20)
                                            .opacity(correctAnswer ? 1.0 : (wrongAnswer ? 1.0 : (timesUp && wrongAnswer && correctAnswer ? 1.0 : 0)))
                                    }
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
                                .frame(height: geo.size.height / 30)
                            Text("During which Caliph’s reign did the Muslims conquer Jerusalem?")
                                .font(.custom("Bungee-Regular", size: geo.size.height / 35.0))
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                                .frame(width: geo.size.width / 1.2, height: geo.size.height / 3)
                            Spacer()
                                .frame(height: geo.size.height / 30)
                            VStack {
                                Button(action: {
                                    correctAnswer = true
                                    score += 1
                                    answerOneActive = true
                                    timeRemaining = 3
                                }) {
                                    ZStack (alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                        Image(correctAnswer && answerOneActive ? "correctQuizButton" : (wrongAnswer && answerOneActive ? "wrongQuizButton" : "quizButton"))
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: geo.size.width / 1.3)
                                        Text("‘Umar")
                                            .font(.custom("PressStart2P-Regular", size: geo.size.height / 40.0))
                                            .foregroundColor(.quizAnswersColour)
                                            .multilineTextAlignment(.center)
                                            .offset(x: geo.size.width / 15.0)
                                    }
                                }
                                .padding(.bottom, 10.0)
                                .disabled(answerOneActive || answerTwoActive || answerThreeActive || timesUp)
                                .buttonStyle(PlainButtonStyle())
                                Button(action: {
                                    wrongAnswer = true
                                    answerTwoActive = true
                                    timeRemaining = 3
                                }) {
                                    ZStack (alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                        Image(correctAnswer && answerTwoActive ? "correctQuizButton" : (wrongAnswer && answerTwoActive ? "wrongQuizButton" : "quizButton"))
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: geo.size.width / 1.3)
                                        Text("‘Ali")
                                            .font(.custom("PressStart2P-Regular", size: geo.size.height / 40.0))
                                            .foregroundColor(.quizAnswersColour)
                                            .multilineTextAlignment(.center)
                                            .offset(x: geo.size.width / 15.0)
                                    }
                                }
                                .padding(.bottom, 10.0)
                                .disabled(answerOneActive || answerTwoActive || answerThreeActive || timesUp)
                                .buttonStyle(PlainButtonStyle())
                                Button(action: {
                                    wrongAnswer = true
                                    answerThreeActive = true
                                    timeRemaining = 3
                                }) {
                                    ZStack (alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                        Image(correctAnswer && answerThreeActive ? "correctQuizButton" : (wrongAnswer && answerThreeActive ? "wrongQuizButton" : "quizButton"))
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: geo.size.width / 1.3)
                                        Text("‘Uthman")
                                            .font(.custom("PressStart2P-Regular", size: geo.size.height / 40.0))
                                            .foregroundColor(.quizAnswersColour)
                                            .multilineTextAlignment(.center)
                                            .offset(x: geo.size.width / 15.0)
                                    }
                                }
                                .disabled(answerOneActive || answerTwoActive || answerThreeActive || timesUp)
                                .buttonStyle(PlainButtonStyle())
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
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    func checkForBest() {
        if score > bestScore {
            bestScore = score
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    
    @State static var isActive: Bool = false
    @State static var bestScore: Int = 0
    
    static var previews: some View {
        QuizView(rootIsActive: $isActive, bestScore: $bestScore)
    }
}

//            Text(selectedQuestions[quizPosition].question)
//                .fontWeight(.bold)
//                .multilineTextAlignment(.center)
//                .padding()
//            ForEach(selectedQuestions[quizPosition].answers.shuffled(), id: \.self) { answer in
//                VStack {
//                    Button(action: {
//                        checkAnswer(selectedQuestions[quizPosition].correctAnswer, answer)
//                    }) {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 25.0, style: .continuous)
//                                .foregroundColor(.black)
//                                .opacity(0.8)
//                            Text(answer)
//                                .foregroundColor(.white)
//                                .padding()
//                        }
//                        .frame(width: 250, height: 100)
//                    }
//                    .alert(isPresented: $endQuiz) {
//                        Alert(title: Text("The game has ended\nYour Score is: \(score)"), message: Text("Play Again?"), dismissButton: .destructive(Text("Play Again")) {
//                          backToMenu()
//                        })
//                    }
//                    .padding()
//                }
//            }
//        }
//        .navigationBarTitle("")
//        .navigationBarBackButtonHidden(true)
//        .navigationBarHidden(true)
//    }

//    func checkAnswer(_ cCA: String, _ sA: String) {
//        if sA == cCA {
//            score += 1
//            quizPosition += 1
//        } else {
//            endQuiz = true
//        }
//    }
//
//    func backToMenu() {
//        self.presentationMode.wrappedValue.dismiss()
//    }
//}
