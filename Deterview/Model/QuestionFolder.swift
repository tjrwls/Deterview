//
//  QuestionFolder.swift
//  Deterview
//
//  Created by 조석진 on 2022/12/01.
//

import Foundation
import RealmSwift

class QuestionFolder: Object {
    @Persisted var id: String = ""
    @Persisted var folderName: String = ""
    @Persisted var category: String = ""
    @Persisted var questionList = List<Question>()
}
