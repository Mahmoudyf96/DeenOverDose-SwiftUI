//
//  quizOrImageTextButton.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-12-11.
//

import SwiftUI

struct AnswerButton: View {
    @State var answerText: String
    @State var imageText: String
    
    @State var geoWidth: CGFloat
    @State var geoHeight: CGFloat
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        if answerText == "" {
            ZStack {
                Image("quizButton")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: sizeClass == .compact ? geoWidth / 1.2 : geoWidth / 1.3)
                Image(imageText)
            }
        } else {
            Image("quizButton")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: sizeClass == .compact ? geoWidth / 1.2 : geoWidth / 1.3)
            Text(answerText)
                .font(.custom("PressStart2P-Regular", size: geoHeight / 40.0))
                .foregroundColor(.quizAnswersColour)
                .multilineTextAlignment(.center)
                .offset(x: geoHeight / 15.0)
        }
    }
}
