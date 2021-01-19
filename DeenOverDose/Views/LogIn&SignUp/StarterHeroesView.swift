//
//  StarterHeroesView.swift
//  DeenOverDose
//
//  Created by McMoodie on 2021-01-17.
//

import SwiftUI

struct StarterHeroButton: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @State var geoWidth: CGFloat
    
    @State var Hero: String
    @Binding var Active: Bool
    
    var body: some View {
            Image(Hero+"Button")
                .resizable()
                .scaledToFit()
                .frame(width: sizeClass == .compact ? geoWidth / 2.5 : geoWidth / 3.3)
                .padding(.horizontal, 5)
                .padding(.top, 5)
                .opacity(Active ? 1 : 0.6)
    }
}

struct StarterHero {
    @State var name: String
    @State var fullName: String
    @State var description: String
}

let StarterHeroes = [
    Hero(name: "Fihri", fullName: "Fatima Al-Fihri", description: "Founder of the world’s\nOldest university"),
    Hero(name: "MansaMusa", fullName: "Mansa Musa", description: "The World’s Wealthiest\nPerson of all time"),
    Hero(name: "Nusaybah", fullName: "Nusaybah bint ka’ab", description: "Defender of the prophet\nIn the battle of uhud"),
    Hero(name: "Ertugrul", fullName: "Ertuğrul Ghazi", description: "Founder of the ottoman\nCaliphate")
]

struct StarterHeroesView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.presentationMode) var presentationMode
    
    @State var firstHeroActive: Bool = true
    @State var secondHeroActive: Bool = false
    @State var thirdHeroActive: Bool = false
    @State var fourthHeroActive: Bool = false
    
    @State var selectedHero: Int = 0
    @Binding var isOBShowing: Bool
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Background()
                VStack {
                    Text("Choose your starter hero")
                        .font(.custom("DeenOD", size: geo.size.height / 23.0))
                        .multilineTextAlignment(.center)
                        .frame(width: sizeClass == .compact ? geo.size.height / 3.0 : geo.size.height / 2.5)
                        .padding(.top, sizeClass == .compact ? geo.size.height / 30.0 : geo.size.height / 40.0)
                    ZStack {
                        Image("HeroRibbon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width / 1.05)
                        Text(StarterHeroes[selectedHero].fullName)
                            .font(.custom("Bungee-Inline", size: geo.size.height / 35.0))
                            .foregroundColor(.white)
                            .offset(y: sizeClass == .compact ? -geo.size.height / 47.0 : -geo.size.height / 36.0)
                    }
                    VStack {
                        HStack (alignment: .center) {
                            BackButton()
                                .onTapGesture {
                                    if selectedHero == 0 {
                                        HeroActive(3)
                                    } else if selectedHero == 1 {
                                        HeroActive(0)
                                    } else if selectedHero == 2 {
                                        HeroActive(1)
                                    } else if selectedHero == 3 {
                                        HeroActive(2)
                                    }
                                }
                            Image(StarterHeroes[selectedHero].name)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width / 2.1)
                                .padding(.bottom)
                            ForwardButton()
                                .onTapGesture {
                                    if selectedHero == 3 {
                                        HeroActive(0)
                                    } else if selectedHero == 2 {
                                        HeroActive(3)
                                    } else if selectedHero == 1 {
                                        HeroActive(2)
                                    } else if selectedHero == 0 {
                                        HeroActive(1)
                                    }
                                }
                        }
                        Text(StarterHeroes[selectedHero].description)
                            .font(.custom("Bungee-Inline", size: geo.size.height / 35.0))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding(.bottom, sizeClass == .compact ? 5 : 30)
                        HStack {
                            StarterHeroButton(geoWidth: geo.size.width, Hero: "Fihri", Active: $firstHeroActive)
                                .onTapGesture {
                                    HeroActive(0)
                                }
                            StarterHeroButton(geoWidth: geo.size.width, Hero: "MansaMusa", Active: $secondHeroActive)
                                .onTapGesture {
                                    HeroActive(1)
                                }
                        }
                        HStack {
                            StarterHeroButton(geoWidth: geo.size.width, Hero: "Nusaybah", Active: $thirdHeroActive)
                                .onTapGesture {
                                    HeroActive(2)
                                }
                            StarterHeroButton(geoWidth: geo.size.width, Hero: "Ertugrul", Active: $fourthHeroActive)
                                .onTapGesture {
                                    HeroActive(3)
                                }
                        }
                    }
                    .offset(y: -25)
                    Button(action : {
                        dismiss()
                    }) {
                        HomeButton(geoWidth: geo.size.width, geoHeight: geo.size.height, buttonText: "Select Hero")
                            .padding(.top, sizeClass == .compact ? 5 : 30)
                    }
                    Spacer()
                        .frame(height: sizeClass == .compact ? geo.size.height / 35.0 : geo.size.height / 15.0)
                }
            }
            .edgesIgnoringSafeArea(.all)
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
    
    func HeroActive(_ hero: Int) {
        if hero == 0 {
            selectedHero = 0
            firstHeroActive = true
            secondHeroActive = false
            thirdHeroActive = false
            fourthHeroActive = false
        } else if hero == 1 {
            selectedHero = 1
            firstHeroActive = false
            secondHeroActive = true
            thirdHeroActive = false
            fourthHeroActive = false
        } else if hero == 2 {
            selectedHero = 2
            firstHeroActive = false
            secondHeroActive = false
            thirdHeroActive = true
            fourthHeroActive = false
        } else if hero == 3 {
            selectedHero = 3
            firstHeroActive = false
            secondHeroActive = false
            thirdHeroActive = false
            fourthHeroActive = true
        }
    }
    
    func dismiss() {
        withAnimation {
            isOBShowing.toggle()
        }
    }
}

struct StarterHeroesView_Previews: PreviewProvider {
    
    static var previews: some View {
        StarterHeroesView(isOBShowing: Binding.constant(true))
    }
}
