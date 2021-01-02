//
//  QuestionViewModel.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-12-12.
//

import Combine
import Firebase

class QuestionViewModel: ObservableObject {
    
    @Published var questions: [Question] = []
    let db = Firestore.firestore()
    
    func getQuestions(set: String) {
        
        db.collection(set).getDocuments { (snap, error) in
            
            guard let data = snap else { return }
            
            self.questions = data.documents.compactMap({ (doc) -> Question? in
                return try? doc.data(as: Question.self)
            })
            
            self.questions = self.questions.shuffled()
        }
    }
}
