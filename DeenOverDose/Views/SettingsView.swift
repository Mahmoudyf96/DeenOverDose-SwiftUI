//
//  SettingsView.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-12-28.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                GreenBackground()
                Text("Hello World!")
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
    static var previews: some View {
        SettingsView()
    }
}
