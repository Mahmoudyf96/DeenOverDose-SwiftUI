//
//  quizOrImageTextButton.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-12-11.
//

import SwiftUI

struct quizImageOrTextButton: View {
    @State var answerText: String
    @State var imageText: String
    
    @State var geoWidth: CGFloat
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        ZStack {
            Image("quizButton")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: sizeClass == .compact ? geoWidth / 1.2 : geoWidth / 1.3)
            Image(imageText)
        }
    }
}
