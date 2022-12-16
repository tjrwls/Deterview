//
//  QuestionFolder.swift
//  Deterview
//
//  Created by 조석진 on 2022/12/01.
//

import Foundation
import RealmSwift

struct QuestionFolder: Identifiable {
    var id = UUID()
    var folderName: String
    var questionList: [Question]
}

class QuestionFolder2: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var folderName: String = ""
    var questionList = List<Question2>()

}
