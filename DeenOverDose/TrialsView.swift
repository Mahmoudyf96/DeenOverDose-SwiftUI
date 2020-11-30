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
            Text("Your Best Score is: \(score)")
            NavigationLink(destination: QuizView()) {
                Text("Trials")
            }
            .padding()
        }
        .frame(width: 400, height: 400)
        .navigationBarTitle("")
    }
}

struct TrialsView_Previews: PreviewProvider {
    static var previews: some View {
        TrialsView()
    }
}
