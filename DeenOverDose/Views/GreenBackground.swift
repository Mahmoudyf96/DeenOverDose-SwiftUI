//
//  GreenBackground.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-12-11.
//

import SwiftUI

struct GreenBackground: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [
            Color(red: 0.004, green: 0.608, blue: 0.302), //019B4D
            Color(red: 0.004, green: 0.482, blue: 0.239), //017B3D
            Color(red: 0, green: 0.345, blue: /*0.32*/ 0.169), //00582B
            Color(red: 0, green: 0.224, blue: /*0.32*/ 0.111) //00391C
        ]), startPoint: .top, endPoint: .bottom)
    }
}

struct GreenBackground_Previews: PreviewProvider {
    static var previews: some View {
        GreenBackground()
    }
}
