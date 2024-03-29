//
//  GameOverView.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-12-11.
//

import SwiftUI

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


struct ResultView: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass

    @Binding var introTime: Int
    @Binding var timeRemaining: Int
    @Binding var gameOver: Bool
    @Binding var shouldPopToRootView: Bool
    
    @Binding var correctAnswer: Bool
    @Binding var wrongAnswer: Bool
    
    @Binding var correctAnswerOne: Bool
    @Binding var correctAnswerTwo: Bool
    @Binding var correctAnswerThree: Bool
    
    @Binding var answerOneActive: Bool
    @Binding var answerTwoActive: Bool
    @Binding var answerThreeActive: Bool
    
    @Binding var score: Int
    @Binding var bestScore: Int
    
    var body: some View {
        GeometryReader { geo in
            VStack (alignment: .center) {
                Spacer()
                Text("Game Over")
                    .font(.custom("DeenOD" , size: geo.size.height / 20.0))
                singlePlayerScoreBoard(score: score, bestScore: bestScore, geoHeight: geo.size.height)
                VStack {
                    Button(action: {
                        introTime = 3
                        timeRemaining = 15
                        correctAnswer = false
                        wrongAnswer = false
                        
                        correctAnswerOne = false
                        correctAnswerTwo = false
                        correctAnswerThree = false
                        
                        answerThreeActive = false
                        answerTwoActive = false
                        answerOneActive = false
                        gameOver = false
                        score = 0
                    }) {
                        ZStack {
                            Image("mBButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width / 1.15)
                            Text("Play Again")
                                .font(.custom("DeenOD" , size: geo.size.height / 28.0))
                                .offset(y: -2)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.bottom, 10)
                    Button(action: {
                        self.shouldPopToRootView = false
                    }) {
                        ZStack {
                            Image("mBButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width / 1.15)
                            Text("Main Menu")
                                .font(.custom("DeenOD" , size: geo.size.height / 28.0))
                                .offset(y: -2)
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
