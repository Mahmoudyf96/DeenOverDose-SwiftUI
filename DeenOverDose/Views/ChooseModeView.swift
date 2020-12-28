//
//  ChooseModeView.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-12-24.
//

import SwiftUI

struct ChooseModeView: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                GreenBackground()
                ZStack {
                    Image("modeButton")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: sizeClass == .compact ? geo.size.width / 1.2 : geo.size.width / 1.3)
                    Image("statsTitle")
                }
            }
        }
    }
}

struct ChooseModeView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseModeView()
    }
}
