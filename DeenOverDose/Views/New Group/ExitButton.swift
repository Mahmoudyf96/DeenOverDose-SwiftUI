//
//  ExitButton.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-12-11.
//

import SwiftUI

struct ExitButton: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        Image("exitButton")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: sizeClass == .compact ? 32 : 40, height: sizeClass == .compact ? 32 : 40)
    }
}

struct ExitButton_Previews: PreviewProvider {
    static var previews: some View {
        ExitButton()
    }
}
