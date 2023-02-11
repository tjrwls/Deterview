//
//  Question.swift
//  Deterview
//
//  Created by 조석진 on 2022/12/01.
//

import Foundation
import RealmSwift

class Question: Object {
    @Persisted var id: String = ""
    @Persisted var question: String = ""
    @Persisted var answer: String = ""
    var parentCategory = LinkingObjects(fromType: QuestionFolder.self, property: "questionList")
}
