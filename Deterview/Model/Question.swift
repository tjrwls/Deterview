//
//  Question.swift
//  Deterview
//
//  Created by 조석진 on 2022/12/01.
//

import Foundation
import RealmSwift
struct Question: Identifiable {
    var id = UUID()
    var question: String
    var answer: String
}

class Question2: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var question: String = ""
    @objc dynamic var answer: String = ""
    var parentCategory = LinkingObjects(fromType: QuestionFolder2.self, property: "questionList")
}
