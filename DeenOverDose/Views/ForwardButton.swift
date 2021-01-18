//
//  ForwardButton.swift
//  DeenOverDose
//
//  Created by McMoodie on 2021-01-03.
//

import SwiftUI

struct ForwardButton: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        Image("forwardButton")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: sizeClass == .compact ? 35 : 70, height: sizeClass == .compact ? 35 : 70)
    }
}

struct ForwardButton_Previews: PreviewProvider {
    static var previews: some View {
        ForwardButton()
    }
}
