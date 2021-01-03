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
            .aspectRatio(contentMode: .fill)
            .frame(width: sizeClass == .compact ? 32 : 40, height: sizeClass == .compact ? 32 : 40)
    }
}

struct ForwardButton_Previews: PreviewProvider {
    static var previews: some View {
        ForwardButton()
    }
}
