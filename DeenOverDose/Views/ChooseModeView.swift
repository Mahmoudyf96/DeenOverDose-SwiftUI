//
//  ChooseModeView.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-12-24.
//

import SwiftUI

struct ChooseModeView: View {
    
    @Binding var rootIsActive: Bool
    @Binding var bestScore: Int
    
    //Analytics
    @Binding var correct: Int
    @Binding var wrong: Int
    @Binding var answered: Int
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                GreenBackground()
                VStack {
                    HStack {
                        Spacer()
                            .frame(width: geo.size.width / 2.8)
                        ZStack {
                            HStack {
                                Image("modeScreenTitle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: sizeClass == .compact ? geo.size.height / 3.5 : geo.size.height / 3.5)
                            }
                        }
                        .frame(width: sizeClass == .compact ? 85 : 120)
                        Spacer()
                            .frame(width: geo.size.width / 5.5)
                        Button(action: {
                            rootIsActive = false
                        }) {
                            ExitButton()
                        }
                        .offset(x: 12)
                        Spacer()
                            .frame(width: geo.size.width / 10.0)
                    }
                    .padding(.top, geo.size.height / 11.0)
                    Spacer()
                        .frame(height: geo.size.height / 9.0)
                    ZStack {
                        Image("modeButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: sizeClass == .compact ? geo.size.width / 1.3 : geo.size.width / 1.4)
                        Image("storyTitle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: sizeClass == .compact ? geo.size.height / 20.5 : geo.size.height / 20.0)
                            .offset(x: -25)
                        Image("storyRibbon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: sizeClass == .compact ? geo.size.width / 6.0 : geo.size.width / 6.5)
                            .offset(x: sizeClass == .compact ? geo.size.width / 4.0 : geo.size.width / 5.0, y: sizeClass == .compact ? geo.size.width / -18.5 : geo.size.width / -25.0)
                    }
                    .padding(.bottom, 20)
                    .offset(x: sizeClass == .compact ? -geo.size.width / 25.5 : -geo.size.width / 14.5)
                    ZStack {
                        Image("modeButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: sizeClass == .compact ? geo.size.width / 1.3 : geo.size.width / 1.4)
                        Image("arenaTitle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: sizeClass == .compact ? geo.size.height / 20.5 : geo.size.height / 20.0)
                            .offset(x: -25)
                        Image("arenaRibbon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: sizeClass == .compact ? geo.size.width / 6.0 : geo.size.width / 6.5)
                            .offset(x: sizeClass == .compact ? geo.size.width / 4.0 : geo.size.width / 5.0, y: sizeClass == .compact ? geo.size.width / -18.5 : geo.size.width / -25.0)
                    }
                    .padding(.bottom, 20)
                    .offset(x: sizeClass == .compact ? geo.size.width / 25.5 : geo.size.width / 14.5)
                    NavigationLink(destination: QuizView(rootIsActive: $rootIsActive, correct: $correct, wrong: $wrong, answered: $answered,  bestScore: $bestScore, set: "trivia-endless")) {
                        ZStack {
                            Image("modeButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: sizeClass == .compact ? geo.size.width / 1.3 : geo.size.width / 1.4)
                            Image("trialsTitle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: sizeClass == .compact ? geo.size.height / 20.5 : geo.size.height / 20.0)
                                .offset(x: -25)
                            Image("trialsRibbon")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: sizeClass == .compact ? geo.size.width / 6.0 : geo.size.width / 6.5)
                                .offset(x: sizeClass == .compact ? geo.size.width / 4.0 : geo.size.width / 5.0, y: sizeClass == .compact ? geo.size.width / -18.5 : geo.size.width / -25.0)
                        }
                    }
                    .padding(.bottom, 20)
                    .offset(x: sizeClass == .compact ? -geo.size.width / 25.5 : -geo.size.width / 14.5)
                    ZStack {
                        Image("modeButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: sizeClass == .compact ? geo.size.width / 1.3 : geo.size.width / 1.4)
                        Image("liveTitle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: sizeClass == .compact ? geo.size.height / 20.5 : geo.size.height / 20.0)
                            .offset(x: -25)
                        Image("liveRibbon")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: sizeClass == .compact ? geo.size.width / 6.0 : geo.size.width / 6.5)
                            .offset(x: sizeClass == .compact ? geo.size.width / 4.0 : geo.size.width / 5.0, y: sizeClass == .compact ? geo.size.width / -18.5 : geo.size.width / -25.0)
                    }
                    .offset(x: sizeClass == .compact ? geo.size.width / 25.5 : geo.size.width / 14.5)
                    Spacer()
                }
            }
            .edgesIgnoringSafeArea(.all)
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct ChooseModeView_Previews: PreviewProvider {
    
    @State static var isActive: Bool = false
    @State static var bestScore: Int = 0
    
    @State static var correct = 0
    @State static var wrong = 0
    @State static var answered = 0
    
    static var previews: some View {
        ChooseModeView(rootIsActive: $isActive, bestScore: $bestScore, correct: $correct, wrong: $wrong, answered: $answered)
    }
}
