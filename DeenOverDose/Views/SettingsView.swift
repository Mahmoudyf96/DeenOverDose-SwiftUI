//
//  SettingsView.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-12-28.
//

import SwiftUI

struct Toggles: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @State var geoHeight: CGFloat
    
    @State var toggleText: String
    @Binding var toggleType: Bool
    
    var body: some View {
        VStack {
            Text(toggleText)
                .font(.custom("DeenOD", size: geoHeight / 25.0))
                .frame(width: sizeClass == .compact ? geoHeight / 4.5 : geoHeight / 2.5)
            Image(toggleType ? "onToggle" : "offToggle")
                .resizable()
                .scaledToFit()
                .frame(width: sizeClass == .compact ? geoHeight / 4.5 : geoHeight / 2.5)
        }
        .onTapGesture {
            toggleType.toggle()
        }
    }
}

struct HomeButton: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @State var geoWidth: CGFloat
    @State var geoHeight: CGFloat
    
    @State var buttonText: String
    
    var body: some View {
        ZStack {
            Image("homeButton")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: sizeClass == .compact ? geoWidth / 1.1 : geoWidth / 1.2)
            Text(buttonText)
                .font(.custom("DeenOD", size: geoHeight / 35.0))
                .offset(y: sizeClass == .compact ? -geoWidth / 150.0 : -geoWidth / 100.0)
        }
        .padding(.top, 5)
    }
}

struct SettingsButton: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @State var geoWidth: CGFloat
    @State var geoHeight: CGFloat
    
    @State var buttonText: String
    @State var buttonImage: String
    
    var body: some View {
        ZStack {
            Image("settingsButton")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: sizeClass == .compact ? geoWidth / 3.8 : geoWidth / 1.2)
            VStack {
                Image(buttonImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: sizeClass == .compact ? geoWidth / 12.5 : geoWidth / 1.2)
                Text(buttonText)
                    .font(.custom("DeenOD", size: geoHeight / 52.0))
            }
        }
        .padding(.vertical, 10)
    }
}

struct SettingsView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @Binding var rootIsActive: Bool
    
    @State var musicToggle: Bool = true
    @State var soundToggle: Bool = true
    
    @State var socials = ["Insta", "Twitter", "YouTube", "Facebook"]
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                GreenBackground()
                VStack {
                    HStack {
                        Spacer()
                            .frame(width: geo.size.width / 2.8)
                        Text("Settings")
                            .font(.custom("DeenOD", size: geo.size.height / 20.0))
                            .frame(width: sizeClass == .compact ? geo.size.height / 3.0 : geo.size.height / 2.5)
                            .frame(width: sizeClass == .compact ? 130 : 200)
                            .offset(y: sizeClass == .compact ? -2 : -4)
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
                    .padding(.top, geo.size.height / 18.0)
                    HStack {
                        Toggles(geoHeight: geo.size.height, toggleText: "Music", toggleType: $musicToggle)
                        Toggles(geoHeight: geo.size.height, toggleText: "Sound", toggleType: $soundToggle)
                    }
                    .padding(.vertical, 20)
                    HomeButton(geoWidth: geo.size.width, geoHeight: geo.size.height, buttonText: "Language")
                    VStack {
                        Text("Socials")
                            .font(.custom("Bungee-Inline", size: geo.size.height / 30.0))
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                        HStack {
                            ForEach(socials, id: \.self) { social in
                                Image(social)
                                    .padding(.horizontal, 10)
                            }
                        }
                    }
                    VStack {
                        Text("Random Hero")
                            .font(.custom("Bungee-Inline", size: geo.size.height / 30.0))
                            .foregroundColor(.white)
                            .padding(.top, 10)
                        HomeButton(geoWidth: geo.size.width, geoHeight: geo.size.height, buttonText: "Purchase: $2.99")
                        HomeButton(geoWidth: geo.size.width, geoHeight: geo.size.height, buttonText: "Hero Bundle: $17.99")
                        HomeButton(geoWidth: geo.size.width, geoHeight: geo.size.height, buttonText: "Restore Purchases")
                    }
                    HStack {
                        SettingsButton(geoWidth: geo.size.width, geoHeight: geo.size.height, buttonText: "Rate App", buttonImage: "rateImage")
                        SettingsButton(geoWidth: geo.size.width, geoHeight: geo.size.height, buttonText: "Credits", buttonImage: "creditsImage")
                        SettingsButton(geoWidth: geo.size.width, geoHeight: geo.size.height, buttonText: "FeedBack", buttonImage: "feedbackImage")
                    }
                    Spacer()
                        .frame(height: sizeClass == .compact ? geo.size.width / 15.0 : geo.size.width / 6.0)
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

struct SettingsView_Previews: PreviewProvider {
    @State static var isActive: Bool = false
    
    static var previews: some View {
        SettingsView(rootIsActive: $isActive)
    }
}
