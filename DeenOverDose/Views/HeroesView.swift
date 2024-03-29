//
//  HeroesView.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-12-28.
//

import SwiftUI

struct HeroButton: View {
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

struct Hero {
    @State var name: String
    @State var fullName: String
    @State var description: String
}

let Heroes = [
    Hero(name: "Fihri", fullName: "Fatima Al-Fihri", description: "Founder of the world’s\nOldest university"),
    Hero(name: "MansaMusa", fullName: "Mansa Musa", description: "The World’s Wealthiest\nPerson of all time"),
    Hero(name: "Nusaybah", fullName: "Nusaybah bint ka’ab", description: "Defender of the prophet\nIn the battle of uhud"),
    Hero(name: "Ertugrul", fullName: "Ertuğrul Ghazi", description: "Founder of the ottoman\nCaliphate")
]

struct HeroesView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.presentationMode) var presentationMode
    
    @State var firstHeroActive: Bool = true
    @State var secondHeroActive: Bool = false
    @State var thirdHeroActive: Bool = false
    @State var fourthHeroActive: Bool = false
    
    @State var selectedHero: Int = 0
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Background()
                VStack {
                    HStack {
                        Spacer()
                            .frame(width: geo.size.width / 10.0)
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            BackButton()
                        }
                        Spacer()
                            .frame(width: sizeClass == .compact ? geo.size.width / 6.2 : geo.size.width / 4.9)
                        Text("Heroes")
                            .font(.custom("DeenOD", size: geo.size.height / 15.0))
                            .frame(width: sizeClass == .compact ? geo.size.height / 3.0 : geo.size.height / 2.5)
                            .frame(width: sizeClass == .compact ? 130 : 200)
                            .offset(y: sizeClass == .compact ? -3 : -4)
                        Spacer()
                            .frame(width: geo.size.width / 2.8)
                    }
                    .padding(.top, sizeClass == .compact ? geo.size.height / 30.0 : geo.size.height / 40.0)
                    ZStack {
                        Image("HeroRibbon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width / 1.05)
                        Text(Heroes[selectedHero].fullName)
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
                            Image(Heroes[selectedHero].name)
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
                        Text(Heroes[selectedHero].description)
                            .font(.custom("Bungee-Inline", size: geo.size.height / 35.0))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding(.bottom, sizeClass == .compact ? 5 : 30)
                        HStack {
                            HeroButton(geoWidth: geo.size.width, Hero: "Fihri", Active: $firstHeroActive)
                                .onTapGesture {
                                    HeroActive(0)
                                }
                            HeroButton(geoWidth: geo.size.width, Hero: "MansaMusa", Active: $secondHeroActive)
                                .onTapGesture {
                                    HeroActive(1)
                                }
                        }
                        HStack {
                            HeroButton(geoWidth: geo.size.width, Hero: "Nusaybah", Active: $thirdHeroActive)
                                .onTapGesture {
                                    HeroActive(2)
                                }
                            HeroButton(geoWidth: geo.size.width, Hero: "Ertugrul", Active: $fourthHeroActive)
                                .onTapGesture {
                                    HeroActive(3)
                                }
                        }
                    }
                    .offset(y: -25)
                    HomeButton(geoWidth: geo.size.width, geoHeight: geo.size.height, buttonText: "Select Hero")
                        .padding(.top, sizeClass == .compact ? 5 : 30)
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
        } else if hero == 3{
            selectedHero = 3
            firstHeroActive = false
            secondHeroActive = false
            thirdHeroActive = false
            fourthHeroActive = true
        }
    }
}

struct HeroesView_Previews: PreviewProvider {
    
    @State static var starterHero: Bool = true
    
    static var previews: some View {
        HeroesView()
    }
}
