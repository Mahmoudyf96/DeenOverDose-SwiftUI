//
//  StoredQuestion+CoreDataProperties.swift
//  DeenOverDose
//
//  Created by McMoodie on 2020-11-15.
//
//

import Foundation
import CoreData


extension StoredQuestion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredQuestion> {
        return NSFetchRequest<StoredQuestion>(entityName: "StoredQuestion")
    }

    @NSManaged public var question: String
    @NSManaged public var correctAnswers: String
    @NSManaged public var topic: String
    @NSManaged public var difficulty: String
    @NSManaged public var reference: String
    @NSManaged public var answers: [String]
    @NSManaged public var id: Int32

    func populate(from quiz: Question) {
        self.question = quiz.question
        self.answers = quiz.answers
        self.correctAnswers = quiz.correctAnswer
        self.topic = quiz.topic
        self.difficulty = quiz.difficulty
        self.reference = quiz.reference
    }
}

extension StoredQuestion : Identifiable {

}
