//
//  CreditsView.swift
//  DeenOverDose
//
//  Created by McMoodie on 2021-01-03.
//

import SwiftUI

struct CreditSocials: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @State var geoWidth: CGFloat
    @State var geoHeight: CGFloat
    
    @State var twitterAt: String
    @State var instaAt: String
    
    @State var title: String
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: geoWidth, height: geoHeight / 25.0)
                Text(title)
                    .font(.custom("Bungee-Inline", size: geoHeight / 45.0))
            }
            .padding(.top)
            VStack (alignment: .leading) {
                HStack {
                    Image("twitterIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(height: geoHeight / 30.0)
                        .padding(.horizontal, 5)
                    Text(twitterAt)
                        .font(.custom("Bungee", size: geoHeight / 40.0))
                        .foregroundColor(.white)
                }
                .padding(.top, 5)
                HStack {
                    Image("instaIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(height: geoHeight / 30.0)
                        .padding(.horizontal, 5)
                    Text(instaAt)
                        .font(.custom("Bungee", size: geoHeight / 40.0))
                        .foregroundColor(.white)
                }
                .padding(.top, 1)
            }
        }
    }
}

struct CreditsView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Background()
                VStack {
                    HStack {
                        Spacer()
                            .frame(width: geo.size.width / 2.8)
                        Text("Credits")
                            .font(.custom("DeenOD", size: geo.size.height / 20.0))
                            .frame(width: sizeClass == .compact ? geo.size.height / 1.5 : geo.size.height / 2.5)
                            .frame(width: sizeClass == .compact ? 130 : 200)
                            .offset(y: sizeClass == .compact ? -2 : -4)
                        Spacer()
                            .frame(width: sizeClass == .compact ? geo.size.width / 5.5 : geo.size.width / 5.5)
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            ExitButton()
                        }
                        Spacer()
                            .frame(width: geo.size.width / 10.0)
                    }
                    .padding(.top, sizeClass == .compact ? geo.size.height / 10.0 : geo.size.height / 40.0)
                    CreditSocials(geoWidth: geo.size.width, geoHeight: geo.size.height, twitterAt: "@JHellyGar", instaAt: "@Just.HellyGar", title: "Designer & Pixel Artist")
                    CreditSocials(geoWidth: geo.size.width, geoHeight: geo.size.height, twitterAt: "@Mahmoudyow", instaAt: "@Mahmou.d.yf", title: "Developer")
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

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
