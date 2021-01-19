//
//  ContentView.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-11-15.
//

import SwiftUI

struct ContentView: View {
    @State var isOnBoardingShowing = true
    @EnvironmentObject var session: SessionStore
    
    func getUser() {
        session.listen()
    }
    
    var body : some View {
        Group {
            if isOnBoardingShowing || session.session == nil {
                OnBoardingView(isOBShowing: $isOnBoardingShowing)
            } else if session.session != nil {
                MainMenuView()
            }
        }
        .onAppear(perform: getUser)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SessionStore())
    }
}
