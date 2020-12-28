//
//  ChooseModeView.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-12-24.
//

import SwiftUI

struct ModeButton: View {
    
    @State var geoWidth: CGFloat
    @State var geoHeight: CGFloat
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @State var title: String
    @State var ribbon: String
    
    @State var right: Bool
    
    var body: some View {
        ZStack {
            Image("modeButton")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: sizeClass == .compact ? geoWidth / 1.3 : geoWidth / 1.4)
            Image(title)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: sizeClass == .compact ? geoHeight / 20.5 : geoHeight / 20.0)
                .offset(x: -25)
            Image(ribbon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: sizeClass == .compact ? geoWidth / 6.0 : geoWidth / 6.5)
                .offset(x: sizeClass == .compact ? geoWidth / 4.0 : geoWidth / 5.0, y: sizeClass == .compact ? geoWidth / -18.5 : geoWidth / -25.0)
        }
        .padding(.bottom, 20)
        .offset(x: sizeClass == .compact ? (right ? geoWidth / 25.5 : -geoWidth / 25.5) : (right ? geoWidth / 14.5 : -geoWidth / 14.5))
    }
}

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
                    ModeButton(geoWidth: geo.size.width, geoHeight: geo.size.height, title: "storyTitle", ribbon: "storyRibbon", right: true)
                    ModeButton(geoWidth: geo.size.width, geoHeight: geo.size.height, title: "arenaTitle", ribbon: "arenaRibbon", right: false)
                    NavigationLink(destination: QuizView(rootIsActive: $rootIsActive, correct: $correct, wrong: $wrong, answered: $answered,  bestScore: $bestScore, set: "trivia-endless")) {
                        ModeButton(geoWidth: geo.size.width, geoHeight: geo.size.height, title: "trialsTitle", ribbon: "trialsRibbon", right: true)
                    }
                    
                    ModeButton(geoWidth: geo.size.width, geoHeight: geo.size.height, title: "liveTitle", ribbon: "liveRibbon", right: false)
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
