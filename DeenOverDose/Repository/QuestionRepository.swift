//
//  QuestionRepository.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-12-17.
//

import Foundation

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

class QuestionRepository: ObservableObject {
    private let path: String = "trivia-endless"
    private let store = Firestore.firestore()
    
    @Published var questions: [Question] = []
    
    func add(_ question: Question) {
        do {
          _ = try store.collection(path).addDocument(from: question)
        } catch {
          fatalError("Unable to add question: \(error.localizedDescription).")
        }
      }
}
