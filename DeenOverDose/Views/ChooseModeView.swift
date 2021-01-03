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
            Text(title)
                .font(.custom("DeenOD", size: geoHeight / 17.0))
                .frame(height: sizeClass == .compact ? geoHeight / 20.5 : geoHeight / 20.0)
                .offset(x: sizeClass == .compact ? -geoWidth / 15.0 : -geoWidth / 15.0, y: sizeClass == .compact ? geoWidth / -80.5 : geoWidth / -100.0)
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
                        HStack {
                            Text("Choose Your Battle")
                                .font(.custom("DeenOD", size: geo.size.height / 35.0))
                                .frame(width: sizeClass == .compact ? geo.size.height / 3.0 : geo.size.height / 2.5)
                                .offset(y: sizeClass == .compact ? -2 : -4)
                        }
                        .frame(width: sizeClass == .compact ? 120 : 200)
                        Spacer()
                            .frame(width: geo.size.width / 4.8)
                        Button(action: {
                            rootIsActive = false
                        }) {
                            ExitButton()
                        }
                        Spacer()
                            .frame(width: geo.size.width / 10.0)
                    }
                    .padding(.top, geo.size.height / 11.0)
                    Spacer()
                        .frame(height: geo.size.height / 9.0)
                    ModeButton(geoWidth: geo.size.width, geoHeight: geo.size.height, title: "Story", ribbon: "storyRibbon", right: true)
                    ModeButton(geoWidth: geo.size.width, geoHeight: geo.size.height, title: "Arena", ribbon: "arenaRibbon", right: false)
                    NavigationLink(destination: QuizView(rootIsActive: $rootIsActive, correct: $correct, wrong: $wrong, answered: $answered,  bestScore: $bestScore, set: "trivia-endless")) {
                        ModeButton(geoWidth: geo.size.width, geoHeight: geo.size.height, title: "Trials", ribbon: "trialsRibbon", right: true)
                    }
                    
                    ModeButton(geoWidth: geo.size.width, geoHeight: geo.size.height, title: "Live", ribbon: "liveRibbon", right: false)
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
