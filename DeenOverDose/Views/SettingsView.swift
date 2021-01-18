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
                .frame(width: sizeClass == .compact ? geoHeight / 5.5 : geoHeight / 5.5)
            Image(toggleType ? "onToggle" : "offToggle")
                .resizable()
                .scaledToFit()
                .frame(height: sizeClass == .compact ? geoHeight / 35.5 : geoHeight / 35.5)
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
            Image("mediumButton")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: sizeClass == .compact ? geoWidth / 1.3 : geoWidth / 1.5)
            Text(buttonText)
                .font(.custom("DeenOD", size: geoHeight / 38.0))
                .offset(y: sizeClass == .compact ? -geoWidth / 150.0 : -geoWidth / 175.0)
        }
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
            Image("smallButton")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: sizeClass == .compact ? geoWidth / 3.8 : geoWidth / 4.8)
            VStack {
                Image(buttonImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: sizeClass == .compact ? geoWidth / 14.5 : geoWidth / 15.0)
                Text(buttonText)
                    .font(.custom("DeenOD", size: geoHeight / 55.0))
            }
        }
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
                Background()
                VStack {
                    HStack {
                        Spacer()
                            .frame(width: geo.size.width / 8.0)
                        Button(action: {
                            rootIsActive = false
                        }) {
                            BackButton()
                        }
                        Spacer()
                            .frame(width: geo.size.width / 6.8)
                        Text("Settings")
                            .font(.custom("DeenOD", size: geo.size.height / 20.0))
                            .frame(width: sizeClass == .compact ? geo.size.height / 3.0 : geo.size.height / 2.5)
                            .frame(width: sizeClass == .compact ? 130 : 200)
                            .offset(y: sizeClass == .compact ? -2 : -4)
                        Spacer()
                            .frame(width: geo.size.width / 2.8)
                    }
                    .padding(.top, sizeClass == .compact ? geo.size.height / 25.0 : geo.size.height / 40.0)
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
                            .padding(.vertical, sizeClass == .compact ? 5 : 10)
                        HStack {
                            ForEach(socials, id: \.self) { social in
                                Image(social)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: sizeClass == .compact ? geo.size.width / 8.5 : geo.size.width / 9.0)
                                    .padding(.horizontal, 10)
                            }
                        }
                    }
                    VStack {
                        Text("Random Hero")
                            .font(.custom("Bungee-Inline", size: geo.size.height / 30.0))
                            .foregroundColor(.white)
                            .padding(.top, sizeClass == .compact ? 5 : 10)
                        HomeButton(geoWidth: geo.size.width, geoHeight: geo.size.height, buttonText: "Purchase: $2.99")
                        HomeButton(geoWidth: geo.size.width, geoHeight: geo.size.height, buttonText: "Hero Bundle: $17.99")
                        HomeButton(geoWidth: geo.size.width, geoHeight: geo.size.height, buttonText: "Restore Purchases")
                    }
                    HStack {
                        SettingsButton(geoWidth: geo.size.width, geoHeight: geo.size.height, buttonText: "Rate App", buttonImage: "rateImage")
                        NavigationLink(destination: CreditsView()) {
                            SettingsButton(geoWidth: geo.size.width, geoHeight: geo.size.height, buttonText: "Credits", buttonImage: "creditsImage")
                        }
                        SettingsButton(geoWidth: geo.size.width, geoHeight: geo.size.height, buttonText: "FeedBack", buttonImage: "feedbackImage")
                    }
                    Spacer()
                        .frame(height: sizeClass == .compact ? geo.size.width / 20.0 : geo.size.width / 25.0)
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
