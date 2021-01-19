//
//  GreenBackground.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-12-11.
//

import SwiftUI

struct Background: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [
            Color(#colorLiteral(red: 0, green: 0.6581824422, blue: 0.3744181395, alpha: 1)),
            Color(#colorLiteral(red: 0, green: 0.2235294118, blue: 0.1098039216, alpha: 1))
        ]), startPoint: .top, endPoint: .bottom)
        .ignoresSafeArea()
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        Background()
    }
}
