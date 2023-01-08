//
//  QuestionFolder.swift
//  Deterview
//
//  Created by 조석진 on 2022/12/01.
//

import Foundation
import RealmSwift

class QuestionFolder: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var folderName: String = ""
    @objc dynamic var category: String = ""
    var questionList = List<Question>()
}
