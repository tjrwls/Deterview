//
//  QuestionFolder.swift
//  Deterview
//
//  Created by 조석진 on 2022/12/01.
//

import Foundation

struct QuestionFolder: Identifiable {
    var id = UUID()
    var folderName: String
    var questionList: [Question]
}

