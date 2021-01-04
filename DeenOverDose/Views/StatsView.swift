//
//  StatsView.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-12-28.
//

import SwiftUI

struct StatsButton: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @State var geoWidth: CGFloat
    @State var geoHeight: CGFloat
    
    @State var title: String
    
    @State var scores: String

    var body: some View {
        VStack {
            Text(title)
                .font(.custom("Bungee-Inline", size: geoHeight / 70.0))
                .foregroundColor(.white)
            ZStack {
                Image("statsButton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geoWidth / 2.5)
                Text(scores)
                    .font(.custom("PressStart2P-Regular", size: geoHeight / 35.0))
                    .foregroundColor(.white)
                    .offset(y: 2)
            }
        }
        .padding(.horizontal, 5)
    }
}

struct StatsView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    @Binding var rootIsActive: Bool
    
    @State var totalMatches: Int = 54
    @State var winLossRatio: Double = 0.34
    @State var totalQuestions: Int = 648
    @State var rightWrongRatio: Double = 1.44
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                GreenBackground()
                VStack {
                    HStack {
                        Spacer()
                            .frame(width: geo.size.width / 2.8)
                        Text("Stats")
                            .font(.custom("DeenOD", size: geo.size.height / 15.0))
                            .frame(width: sizeClass == .compact ? geo.size.height / 3.0 : geo.size.height / 2.5)
                            .frame(width: sizeClass == .compact ? 130 : 200)
                            .offset(y: sizeClass == .compact ? -3 : -4)
                        Spacer()
                            .frame(width: sizeClass == .compact ? geo.size.width / 6.2 : geo.size.width / 4.9)
                        Button(action: {
                            rootIsActive = false
                        }) {
                            ExitButton()
                        }
                        Spacer()
                            .frame(width: geo.size.width / 10.0)
                    }
                    .padding(.top, sizeClass == .compact ? geo.size.height / 15.0 : geo.size.height / 40.0)
                    Image("RadarChart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width / 1.1)
                        .padding()
                    VStack {
                        HStack {
                            StatsButton(geoWidth: geo.size.width, geoHeight: geo.size.height, title: "Total Matches", scores: String(totalMatches))
                            StatsButton(geoWidth: geo.size.width, geoHeight: geo.size.height, title: "Win / Loss Ratio", scores: String(winLossRatio))
                        }
                        HStack {
                            StatsButton(geoWidth: geo.size.width, geoHeight: geo.size.height, title: "Total Questions", scores: String(totalQuestions))
                            StatsButton(geoWidth: geo.size.width, geoHeight: geo.size.height, title: "Right / Wrong Ratio", scores: String(rightWrongRatio))
                        }
                    }
                    .padding(.top)
                    Spacer()
                    HomeButton(geoWidth: geo.size.width, geoHeight: geo.size.height, buttonText: "Reset Stats")
                        .padding(.top, 20)
                    Spacer()
                        .frame(height: sizeClass == .compact ? geo.size.width / 10.0 : geo.size.width / 25.0)
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

struct StatsView_Previews: PreviewProvider {
    @State static var isActive: Bool = false
    
    static var previews: some View {
        StatsView(rootIsActive: $isActive)
    }
}
