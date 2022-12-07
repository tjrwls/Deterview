//
//  Question.swift
//  Deterview
//
//  Created by 조석진 on 2022/12/01.
//

import Foundation

struct Question: Identifiable {
    var id = UUID()
    var question: String
    var answer: String
}
