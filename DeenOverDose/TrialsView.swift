//
//  TrialsView.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-11-19.
//

import SwiftUI

struct TrialsView: View {
    
    @State private var score = 0
    
    var body: some View {
        VStack {
            NavigationLink(destination: QuizView()) {
                Text("Trials")
            }
            .padding()
            Text("Your Best Score is: \(score)")
        }
        .frame(width: 400, height: 400)
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

struct TrialsView_Previews: PreviewProvider {
    static var previews: some View {
        TrialsView()
    }
}
