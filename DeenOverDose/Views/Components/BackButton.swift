//
//  BackButton.swift
//  DeenOverDose
//
//  Created by McMoodie on 2021-01-03.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        Image("backButton")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: sizeClass == .compact ? 30 : 70, height: sizeClass == .compact ? 30 : 70)
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
    }
}
