//
//  TemplateData.swift
//  Deterview
//
//  Created by 조석진 on 2022/12/01.
//

import Foundation

var csFolder: QuestionFolder = QuestionFolder(folderName: "CS", questionList: csQuestion)
var iOSFolder: QuestionFolder = QuestionFolder(folderName: "iOS", questionList: iosQuestion)
var aOSFolder: QuestionFolder = QuestionFolder(folderName: "aOS", questionList: aosQuestion)
var frontEndFolder: QuestionFolder = QuestionFolder(folderName: "Front-End", questionList: frontendQuestion)
var backEndFolder: QuestionFolder = QuestionFolder(folderName: "Back-End", questionList: backendQuestion)




var csQuestion: [Question] = [
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "두번째 질문", answer: "답변"),
    Question(question: "세번째 질문", answer: "답변")]

var iosQuestion: [Question] = [
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "첫번째 질문", answer: "답변")]

var aosQuestion: [Question] = [
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "첫번째 질문", answer: "답변")]

var frontendQuestion: [Question] = [
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "첫번째 질문", answer: "답변")]

var backendQuestion: [Question] = [
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "첫번째 질문", answer: "답변")]

class TemplateData {
    var templateData: [QuestionFolder] = [csFolder, iOSFolder, aOSFolder, frontEndFolder, backEndFolder]
    
    var countOfFolde: Int {
          return templateData.count
      }
  
      func cellInfo(at index: Int) -> QuestionFolder {
          return templateData[index]
      }
}
