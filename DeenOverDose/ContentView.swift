//
//  ContentView.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-11-15.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    Image("backgroundImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    VStack (alignment: .center) {
                        Spacer()
                        Image("DeenOD - HomeLogo")
                            .padding(.bottom, 50)
                        ZStack {
                            Image("backgroundProfile")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width - 75)
                            HStack {
                                Image("Al Fihri")
                                    .offset(x: 10)
                                VStack (alignment: .leading) {
                                    Image("UI1")
                                        .offset(x: 10)
                                    Image("UI-1")
                                        .offset(x: 10, y: -5)
                                    ZStack {
                                        Image("Rectangle 112")
                                        Image("Group 329")
                                            .offset(x: -45)
                                        Image("UI-2")
                                            .offset(x: 10)
                                    }
                                    .frame(width: 141, height: 50)
                                    .offset(x: 5)
                                }
                                .offset(x: 2)
                                Image("PrestigeThree")
                            }
                        }
                        .padding(.vertical, 30)
                        VStack {
                            ZStack {
                                Image("homeButton")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geo.size.width - 40)
                                Image("startingJourney")
                            }
                            ZStack {
                                Image("homeButton")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geo.size.width - 40)
                                Image("heroesTitle")
                            }
                            .padding(.top, 10)
                            ZStack {
                                Image("homeButton")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geo.size.width - 40)
                                Image("statsTitle")
                                
                            }
                            .padding(.top, 10)
                            ZStack {
                                Image("homeButton")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: geo.size.width - 40)
                                Image("settingsTitle")
                            }
                            .padding(.top, 10)
                        }
                        Spacer()
                    }
                    .offset(y: -10)
                }
                .edgesIgnoringSafeArea(.all)
                .frame(width: geo.size.width, height: geo.size.height)
            }
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
