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

struct GameOver: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @Binding var timeRemaining: Int
    @Binding var gameOver: Bool
    @Binding var shouldPopToRootView: Bool
    
    var body: some View {
        GeometryReader { geo in
            VStack (alignment: .center) {
                Spacer()
                Image("gameOver")
                Spacer()
                    .frame(height: geo.size.height / 12.0)
                VStack {
                    Text("SCORE")
                        .font(.custom("PressStart2P-Regular", size: geo.size.height / 45.0))
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                    Text("5")
                        .font(.custom("PressStart2P-Regular", size: geo.size.height / 14.0))
                        .foregroundColor(.white)
                }
                Spacer()
                    .frame(height: geo.size.height / 16.0)
                VStack {
                    Text("BEST")
                        .font(.custom("PressStart2P-Regular", size: geo.size.height / 45.0))
                        .foregroundColor(.white)
                        .padding(.bottom, 10)
                    Text("34")
                        .font(.custom("PressStart2P-Regular", size: geo.size.height / 14.0))
                        .foregroundColor(.white)
                }
                Spacer()
                    .frame(height: geo.size.height / 10.0)
                VStack {
                    Button(action: {
                        timeRemaining = 12
                        gameOver = false
                    }) {
                        ZStack {
                            Image("quizButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: sizeClass == .compact ? geo.size.width / 1.2 : geo.size.width / 1.3)
                            Image("playAgain")
                        }
                        .padding(.bottom, 20)
                    }
                    .buttonStyle(PlainButtonStyle())
                    Button(action: {
                        self.shouldPopToRootView = false
                    }) {
                        ZStack {
                            Image("quizButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: sizeClass == .compact ? geo.size.width / 1.2 : geo.size.width / 1.3)
                            Image("mainMenuText")
                        }
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

struct QuizView: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @Binding var rootIsActive: Bool
    
    @State private var score = 0
    @State private var quizPosition = 0
    @State private var answer1 = false
    @State private var answer2 = false
    @State private var answer3 = false
    
    @State private var timesUp = false
    @State private var gameOver = false
    
    @State var timeRemaining = 12
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [
                        Color(red: 0.004, green: 0.608, blue: 0.302), //019B4D
                        Color(red: 0.004, green: 0.482, blue: 0.239), //017B3D
                        Color(red: 0, green: 0.345, blue: /*0.32*/ 0.169), //00582B
                        Color(red: 0, green: 0.224, blue: /*0.32*/ 0.111) //00391C
                    ]), startPoint: .top, endPoint: .bottom)
                    if gameOver {
                        GameOver(timeRemaining: $timeRemaining, gameOver: $gameOver, shouldPopToRootView: $rootIsActive)
                    } else {
                        VStack {
                            HStack {
                                Spacer()
                                    .frame(width: geo.size.width / 2.8)
                                HStack {
                                    Text(":")
                                        .kerning(-geo.size.height / 55.0)
                                        .font(.custom("PressStart2P-Regular", size: geo.size.height / 28.0))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                    Text("\(timeRemaining)")
                                        .kerning(-1)
                                        .font(.custom("PressStart2P-Regular", size: geo.size.height / 28.0))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.center)
                                        .onReceive(timer) { _ in
                                            if self.timeRemaining > 1 {
                                                self.timeRemaining -= 1
                                            } else {
                                                timesUp = true
                                                gameOver = true
                                            }
                                        }
                                }
                                .frame(width: sizeClass == .compact ? geo.size.width / 5.0 : geo.size.width / 7.0)
                                Spacer()
                                    .frame(width: geo.size.width / 4.8)
                                Button(action: {
                                    rootIsActive = false
                                }) {
                                    Image("exitButton")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: sizeClass == .compact ? geo.size.width / 12.0 : geo.size.width / 18.0, height: sizeClass == .compact ? geo.size.height / 12.0 : geo.size.height / 18.0)
                                }
                                Spacer()
                                    .frame(width: geo.size.width / 10.0)
                            }
                            .padding(.top, geo.size.height / 12.0)
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
                                    answer1.toggle()
                                }) {
                                    ZStack (alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                        Image(answer1 ? "correctQuizButton" : "quizButton")
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
                                    answer2.toggle()
                                }) {
                                    ZStack (alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                        Image(answer2 ? "wrongQuizButton" : "quizButton")
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
                                    answer3.toggle()
                                }) {
                                    ZStack (alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                        Image(answer3 ? "wrongQuizButton" : "quizButton")
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
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarBackButtonHidden(true)
    }
}

struct QuizView_Previews: PreviewProvider {
    
    @State static var isActive: Bool = false
    
    static var previews: some View {
        QuizView(rootIsActive: $isActive)
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
