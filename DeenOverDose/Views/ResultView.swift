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
                        timeRemaining = 15
                        gameOver = false
                        score = 0
                    }) {
                        AnswerButton(answerText: "", imageText: "playAgain", geoWidth: geo.size.width, geoHeight: geo.size.height)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.bottom, 10)
                    Button(action: {
                        self.shouldPopToRootView = false
                    }) {
                        AnswerButton(answerText: "", imageText: "mainMenuText", geoWidth: geo.size.width, geoHeight: geo.size.height)
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
