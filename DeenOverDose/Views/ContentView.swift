//
//  ContentView.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-11-15.
//

import SwiftUI

struct ContentView: View {
    @State private var isOnBoardingShowing = true
    
    var body : some View {
        Group {
            if isOnBoardingShowing {
                OnBoardingView(isOBShowing: $isOnBoardingShowing)
            } else {
                MainMenuView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
