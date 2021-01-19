//
//  QuestionViewModel.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-12-12.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class QuestionViewModel: ObservableObject {
    
    @Published var questions: [Question] = []
    let db = Firestore.firestore()
    
    func getQuestions() {
        
        db.collection("trivia-endless").getDocuments { (querySnapshot, error) in
            
            guard let documents = querySnapshot?.documents else {
                print("No Documents!")
                return
            }
            
            self.questions = documents.compactMap { queryDocumentSnapshot -> Question? in
                return try? queryDocumentSnapshot.data(as: Question.self)
            }
            
            self.questions = self.questions.shuffled()
        }
    }
}
