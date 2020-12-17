//
//  QuestionViewModel.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-12-12.
//

import SwiftUI
import Firebase

class QuestionViewModel: ObservableObject {
    @Published var questions: [Question] = []
    
    let db = Firestore.firestore()
    
    func getQuestions(set: String) {
        
        
        
    }
}
