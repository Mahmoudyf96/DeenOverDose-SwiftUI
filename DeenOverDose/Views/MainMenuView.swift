//
//  HomeView.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-12-12.
//

import SwiftUI

struct MainMenuView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @State var isActive: Bool = false
    @State var bestScore: Int = 0
    
    //Analytics
    @State var correct = 0
    @State var wrong = 0
    @State var answered = 0

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
                                Image("Username")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: sizeClass == .compact ? geo.size.width / 3.4 : geo.size.width / 4.0)
                                    .offset(y: 15)
                                ZStack {
                                    Image("homeCharacterButton")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: sizeClass == .compact ? geo.size.width / 2.35 : geo.size.width / 3.0)
                                    HStack {
                                        Image("Al Fihri-Half")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: sizeClass == .compact ? geo.size.width / 6.3 : geo.size.width / 8.3)
                                            .offset(x: sizeClass == .compact ? -geo.size.width / 500 : geo.size.width / 500)
                                        Image("PrestigeThree")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: sizeClass == .compact ? geo.size.width / 4.65 : geo.size.width / 5.3)
                                            .offset(x: -geo.size.width / 50)
                                    }
                                    .offset(y: 5)
                                }
                                .offset(y: 2)
                            }
                            VStack {
                                Image("Level")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: sizeClass == .compact ? geo.size.width / 5.0 : geo.size.width / 6.5)
                                    .offset(y: 20)
                                ZStack {
                                    Image("homeStatButton")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: sizeClass == .compact ? geo.size.width / 2.35 : geo.size.width / 3.0)
                                        .offset(y: 10)
                                    VStack {
                                        Image("winLossText")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: sizeClass == .compact ? geo.size.width / 6.3 : geo.size.width / 8.0)
                                            .offset(x: sizeClass == .compact ? -geo.size.width / 13 : -geo.size.width / 15)
                                            .padding(.top)
                                        Image("rightWrongText")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: sizeClass == .compact ? geo.size.width / 6.3 : geo.size.width / 8.0)
                                            .offset(x: sizeClass == .compact ? -geo.size.width / 13 : -geo.size.width / 15)
                                    }
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
                                    Image("TrophyPos")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: sizeClass == .compact ? geo.size.width / 6.0 : geo.size.width / 7.5)
                                        .offset(x:  sizeClass == .compact ? geo.size.width / 18.0 : geo.size.width / 23.0)
                                }
                            }
                        }
                        .padding(.bottom, 5)
                        VStack {
                            NavigationLink(destination: ChooseModeView(rootIsActive: $isActive, bestScore: $bestScore, correct: $correct, wrong: $wrong, answered: $answered), isActive: $isActive) {
                                ZStack {
                                    Image("homeButton")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: sizeClass == .compact ? geo.size.width / 1.1 : geo.size.width / 1.2)
                                    Image("startingJourney")
                                }
                            }
                            .isDetailLink(false)
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                            .buttonStyle(PlainButtonStyle())
                            NavigationLink(destination: HeroesView()) {
                                ZStack {
                                    Image("homeButton")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: sizeClass == .compact ? geo.size.width / 1.1 : geo.size.width / 1.2)
                                    Image("heroesTitle")
                                }
                                .padding(.top, 10)
                            }
                            NavigationLink(destination: StatsView()) {
                                ZStack {
                                    Image("homeButton")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: sizeClass == .compact ? geo.size.width / 1.1 : geo.size.width / 1.2)
                                    Image("statsTitle")
                                    
                                }
                                .padding(.top, 10)
                            }
                            NavigationLink(destination: SettingsView()) {
                                ZStack {
                                    Image("homeButton")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: sizeClass == .compact ? geo.size.width / 1.1 : geo.size.width / 1.2)
                                    Image("settingsTitle")
                                }
                                .padding(.top, 10)
                            }
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
