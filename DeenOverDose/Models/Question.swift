//
//  Question.swift
//  DeenOD-App
//
//  Created by McMoodie on 2020-11-14.
//

import Foundation
import FirebaseFirestoreSwift

struct Question: Codable, Identifiable {
    
    @DocumentID var id: String?
    var question: String
    var answers: [String]
    var correctAnswer: String
    var topic: String
    var difficulty: String
    var reference: String
    
    enum CodingKeys: CodingKey {
        case question
        case answers
        case correctAnswer
        case topic
        case difficulty
        case reference
    }
}
