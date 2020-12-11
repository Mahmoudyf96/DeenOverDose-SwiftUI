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
}

struct greenBackground: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [
            Color(red: 0.004, green: 0.608, blue: 0.302), //019B4D
            Color(red: 0.004, green: 0.482, blue: 0.239), //017B3D
            Color(red: 0, green: 0.345, blue: /*0.32*/ 0.169), //00582B
            Color(red: 0, green: 0.224, blue: /*0.32*/ 0.111) //00391C
        ]), startPoint: .top, endPoint: .bottom)
    }
}

struct singlePlayerScoreBoard: View {
    @State var score: Int
    @State var bestScore: Int
    
    @State var geoHeight: CGFloat
    
    var body: some View {
        Group {
            Spacer()
                .frame(height: geoHeight / 12.0)
            VStack {
                Text("SCORE")
                    .font(.custom("PressStart2P-Regular", size: geoHeight / 45.0))
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                Text("\(score)")
                    .font(.custom("PressStart2P-Regular", size: geoHeight / 14.0))
                    .foregroundColor(.white)
            }
            Spacer()
                .frame(height: geoHeight / 16.0)
            VStack {
                Text("BEST")
                    .font(.custom("PressStart2P-Regular", size: geoHeight / 45.0))
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                Text("\(bestScore)")
                    .font(.custom("PressStart2P-Regular", size: geoHeight / 14.0))
                    .foregroundColor(.white)
            }
            Spacer()
                .frame(height: geoHeight / 10.0)
        }
    }
}

struct quizImageOrTextButton: View {
    @State var answerText: String
    @State var imageText: String
    
    @State var geoWidth: CGFloat
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        ZStack {
            Image("quizButton")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: sizeClass == .compact ? geoWidth / 1.2 : geoWidth / 1.3)
            Image(imageText)
        }
    }
}

struct GameOverView: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @Binding var timeRemaining: Int
    @Binding var gameOver: Bool
    @Binding var shouldPopToRootView: Bool
    
    @Binding var score: Int
    @Binding var bestScore: Int
    
    var body: some View {
        GeometryReader { geo in
            VStack (alignment: .center) {
                Spacer()
                Image("gameOver")
                singlePlayerScoreBoard(score: score, bestScore: bestScore, geoHeight: geo.size.height)
                VStack {
                    Button(action: {
                        timeRemaining = 12
                        gameOver = false
                        score = 0
                    }) {
                        quizImageOrTextButton(answerText: "", imageText: "playAgain", geoWidth: geo.size.width)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.bottom, 10)
                    Button(action: {
                        self.shouldPopToRootView = false
                    }) {
                        quizImageOrTextButton(answerText: "", imageText: "mainMenuText", geoWidth: geo.size.width)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                Spacer()
            }
            .edgesIgnoringSafeArea(.all)
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

struct ExitButton: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        Image("exitButton")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: sizeClass == .compact ? 27 : 40, height: sizeClass == .compact ? 27 : 40)
    }
}

struct QuizView: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @Binding var rootIsActive: Bool
    
    @State private var quizPosition = 0
    @State private var correctAnswer = false
    @State private var incorrectAnswer = false
    
    @State private var gameOver = false
    
    @State var score = 0
    @Binding var bestScore: Int
    
    @State var timeRemaining = 15
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    greenBackground()
                    if gameOver {
                        GameOverView(timeRemaining: $timeRemaining, gameOver: $gameOver, shouldPopToRootView: $rootIsActive, score: $score, bestScore: $bestScore)
                    } else {
                        VStack {
                            HStack {
                                Spacer()
                                    .frame(width: geo.size.width / 2.8)
                                
//                                ZStack {
//                                    HStack {
//                                        Text(":")
//                                            .kerning(-geo.size.height / 55.0)
//                                            .font(.custom("PressStart2P-Regular", size: geo.size.height / 28.0))
//                                            .foregroundColor(.white)
//                                            .multilineTextAlignment(.center)
//                                        Text("\(timeRemaining)")
//                                            .kerning(-1)
//                                            .font(.custom("PressStart2P-Regular", size: geo.size.height / 28.0))
//                                            .foregroundColor(.white)
//                                            .multilineTextAlignment(.center)
//                                            .onReceive(timer) { _ in
//                                                if self.timeRemaining > 4 {
//                                                    self.timeRemaining -= 1
//                                                } else if self.timeRemaining < 4 && self.timeRemaining > 1 {
//                                                    checkForBest()
//                                                } else {
//                                                    gameOver = true
//                                                }
//                                            }
//                                    }
                                    Circle()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: sizeClass == .compact ? 60 : 120, height: sizeClass == .compact ? 20 : 40)
                                        .offset(x: sizeClass == .compact ? 7 : 20)
//                                }
//                                .frame(width: sizeClass == .compact ? 85 : 120)
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
                                    correctAnswer.toggle()
                                    score += 1
                                }) {
                                    ZStack (alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                        Image(correctAnswer ? "correctQuizButton" : (incorrectAnswer ? "wrongQuizButton" : "quizButton"))
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
                                .buttonStyle(PlainButtonStyle())
                                .padding(.bottom, 10.0)
                                Button(action: {
                                    incorrectAnswer.toggle()
                                }) {
                                    ZStack (alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                        Image(correctAnswer ? "correctQuizButton" : (incorrectAnswer ? "wrongQuizButton" : "quizButton"))
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
                                .buttonStyle(PlainButtonStyle())
                                .padding(.bottom, 10.0)
                                Button(action: {
                                    incorrectAnswer.toggle()
                                }) {
                                    ZStack (alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                        Image(correctAnswer ? "correctQuizButton" : (incorrectAnswer ? "wrongQuizButton" : "quizButton"))
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
