//
//  Question.swift
//  DeenOD-App
//
//  Created by McMoodie on 2020-11-14.
//

import Foundation

struct Question: Codable, Identifiable, Hashable {
    var id: Int32
    var question: String
    var answers: [String]
    var correctAnswer: String
    var topic: String
    var difficulty: String
    var reference: String

}
