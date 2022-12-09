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
var iOS2Folder: QuestionFolder = QuestionFolder(folderName: "iOS2", questionList: iosQuestion)
var aOS2Folder: QuestionFolder = QuestionFolder(folderName: "aOS2", questionList: aosQuestion)



var csQuestion: [Question] = [
    Question(question: "1-1", answer: "답변1-1"),
    Question(question: "1-2", answer: "답변2"),
    Question(question: "네트워크 서버에서 트래픽 과부하가 발생할 경우 어떻게 할 것인가?", answer: "네트워크 서버에서 트래픽 과부하가 발생할 경우 어떻게 할 것인가 네트워크 서버에서 트래픽 과부하가 발생할 경우 어떻게 할 것인가 네트워크 서버에서 트래픽 과부하가 발생할 경우 어떻게 할 것인가 네트워크 서버에서 트래픽 과부하가 발생할 경우 어떻게 할 것인가 네트워크 서버에서 트래픽 과부하가 발생할 경우 어떻게 할 것인가 네트워크 서버에서 트래픽 과부하가 발생할 경우 어떻게 할 것인가 네트워크 서버에서 트래픽 과부하가 발생할 경우 어떻게 할 것인가 네트워크 서버에서 트래픽 과부하가 발생할 경우 어떻게 할 것인가 네트워크 서버에서 트래픽 과부하가 발생할 경우 어떻게 할 것인가 네트워크 서버에서 트래픽 과부하가 발생할 경우 어떻게 할 것인가 네트워크 서버에서 트래픽 과부하가 발생할 경우 어떻게 할 것인가 네트워크 서버에서 트래픽 과부하가 발생할 경우 어떻게 할 것인가")]

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
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "첫번째 질문", answer: "답변")]

var backendQuestion: [Question] = [
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "첫번째 질문", answer: "답변")]

var ios2Question: [Question] = [
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "첫번째 질문", answer: "답변")]

var aos2Question: [Question] = [
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "첫번째 질문", answer: "답변"),
    Question(question: "첫번째 질문", answer: "답변")]
class TemplateData {
    var templateData: [QuestionFolder] = [csFolder, iOSFolder, aOSFolder, frontEndFolder, backEndFolder, iOS2Folder,  aOS2Folder]
    
    var countOfFolde: Int {
          return templateData.count
      }
  
      func cellInfo(at index: Int) -> QuestionFolder {
          return templateData[index]
      }
}
