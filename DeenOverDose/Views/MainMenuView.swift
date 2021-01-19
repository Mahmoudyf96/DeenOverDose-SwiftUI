//
//  HomeView.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-12-12.
//

import SwiftUI

struct MainMenuView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @State var modeIsActive: Bool = false
    @State var heroesIsActive: Bool = false
    @State var statsIsActive: Bool = false
    @State var settingsIsActive: Bool = false
    
    @State var bestScore: Int = 0
    
    //Analytics
    @State var correct = 0
    @State var wrong = 0
    @State var answered = 648
    
    @State var winLossRatio = 0.34
    @State var rightWrongRatio = 1.44

    var body: some View {
        NavigationView {
            GeometryReader { geo in
                Spacer()
                    .frame(height: sizeClass == .compact ? geo.size.height / 25.0 : geo.size.height / 6.0)
                ZStack {
                    Image("backgroundImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    VStack (alignment: .center) {
                        
                        Image("DeenOD - HomeLogo")
                        HStack {
                            VStack {
                                Text("DeenOD")
                                    .font(.custom("DeenOD", size: geo.size.height / 35.0))
                                    .offset(y: 15)
                                ZStack {
                                    Image("homeCharacterButton")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: sizeClass == .compact ? geo.size.width / 2.35 : geo.size.width / 3.0)
                                    HStack {
                                        Image("FihriHalf")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(height: sizeClass == .compact ? geo.size.height / 5.0  : geo.size.height / 4.5)
                                            .offset(x: sizeClass == .compact ? geo.size.width / 27.0 : geo.size.width / 150.0, y: sizeClass == .compact ? -geo.size.height / 75.0 : -geo.size.height / 75.0)
                                        Image("PrestigeThree")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: sizeClass == .compact ? geo.size.width / 4.65 : geo.size.width / 5.3)
                                            .offset(x: sizeClass == .compact ? -geo.size.width / 27.0 : -geo.size.width / 75.0)
                                    }
                                    .offset(y: 5)
                                }
                                .offset(y: 2)
                            }
                            VStack {
                                Text("Level 3")
                                    .font(.custom("DeenOD", size: geo.size.height / 35.0))
                                    .offset(y: 20)
                                ZStack {
                                    Image("homeStatButton")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: sizeClass == .compact ? geo.size.width / 2.35 : geo.size.width / 3.0)
                                        .offset(y: 10)
                                    VStack (alignment: .leading) {
                                        Text("W/L: \(winLossRatio, specifier: "%.2f")")
                                            .font(.custom("DeenOD", size: geo.size.height / 35.0))
                                        Text("R/W: \(rightWrongRatio, specifier: "%.2f")")
                                            .font(.custom("DeenOD", size: geo.size.height / 35.0))
                                    }
                                    .offset(y: geo.size.height / 100.0)
                                }
                                ZStack {
                                    Image("homeStatButton")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: sizeClass == .compact ? geo.size.width / 2.35 : geo.size.width / 3.0)
                                    Image("Trophy")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: sizeClass == .compact ? geo.size.width / 3.5 : geo.size.width / 4.5)
                                    Text("344K")
                                        .font(.custom("DeenOD", size: geo.size.height / 40.0))
                                        .offset(x:  sizeClass == .compact ? geo.size.width / 18.0 : geo.size.width / 23.0)
                                }
                            }
                        }
                        .padding(.bottom, 5)
                        VStack {
                            NavigationLink(destination: ChooseModeView(rootIsActive: $modeIsActive, bestScore: $bestScore, correct: $correct, wrong: $wrong, answered: $answered), isActive: $modeIsActive) {
                                ZStack {
                                    Image("mediumButton")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: sizeClass == .compact ? geo.size.width / 1.1 : geo.size.width / 1.2)
                                    Text("Start Your Journey")
                                        .font(.custom("DeenOD", size: geo.size.height / 32.0))
                                        .offset(y: -geo.size.height / 200.0)
                                }
                            }
                            .isDetailLink(false)
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                            .buttonStyle(PlainButtonStyle())
                            NavigationLink(destination: HeroesView(), isActive: $heroesIsActive) {
                                ZStack {
                                    Image("mediumButton")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: sizeClass == .compact ? geo.size.width / 1.1 : geo.size.width / 1.2)
                                    Text("Heroes")
                                        .font(.custom("DeenOD", size: geo.size.height / 32.0))
                                        .offset(y: -geo.size.height / 200.0)
                                }
                                .padding(.top, 10)
                            }
                            .isDetailLink(false)
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                            .buttonStyle(PlainButtonStyle())
                            NavigationLink(destination: StatsView(rootIsActive: $statsIsActive, totalQuestions: answered, winLossRatio: winLossRatio, rightWrongRatio: rightWrongRatio), isActive: $statsIsActive) {
                                ZStack {
                                    Image("mediumButton")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: sizeClass == .compact ? geo.size.width / 1.1 : geo.size.width / 1.2)
                                    Text("Stats")
                                        .font(.custom("DeenOD", size: geo.size.height / 32.0))
                                        .offset(y: -geo.size.height / 200.0)
                                    
                                }
                                .padding(.top, 10)
                            }
                            .isDetailLink(false)
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                            .buttonStyle(PlainButtonStyle())
                            NavigationLink(destination: SettingsView(rootIsActive: $settingsIsActive), isActive: $settingsIsActive) {
                                ZStack {
                                    Image("mediumButton")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: sizeClass == .compact ? geo.size.width / 1.1 : geo.size.width / 1.2)
                                    Text("Settings")
                                        .font(.custom("DeenOD", size: geo.size.height / 32.0))
                                        .offset(y: -geo.size.height / 200.0)
                                }
                                .padding(.top, 10)
                            }
                            .isDetailLink(false)
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
                .frame(width: geo.size.width + 3, height: geo.size.height)
                Spacer()
                    .frame(height: sizeClass == .compact ? geo.size.width / 25.0 : geo.size.width / 6.0)
            }
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
