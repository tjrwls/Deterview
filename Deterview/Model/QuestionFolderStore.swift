//
//  QuestionStore.swift
//  Deterview
//
//  Created by MIJU on 2022/12/13.
//
//
import Foundation
import RealmSwift

class QuestionFolderStore {
    var mainQuestionFolders: [QuestionFolder] = []
    var customQuestionFolders: [QuestionFolder] = []
    let realm = try! Realm()
    
    // MARK: 폴더 추가하기
    func createdQuestionFolder(_ questionFolder: QuestionFolder) {
        let createFolder = QuestionFolder()
        createFolder.id = UUID().uuidString
         createFolder.folderName = questionFolder.folderName
        createFolder.category = "Custom"
        try? self.realm.write {
            self.realm.add(createFolder)
        }
    }
    
    // MARK: 플더 불러오기
    func readQuestionFolder() {
        let folderData = self.realm.objects(QuestionFolder.self)
        mainQuestionFolders = Array(folderData).filter { $0.category == "Main" }
        customQuestionFolders = Array(folderData).filter { $0.category == "Custom" }
    }
    
    // MARK: 플더 수정하기
    func updateQuestionFolder(id: String, name: String) {
        if let questionFolder = realm.objects(QuestionFolder.self).filter(NSPredicate(format: "id = %@", id)).first {
            try? realm.write {
                questionFolder.folderName = name
            }
        }
    }
    
    // MARK: 플더 삭제하기
    func deleteQuestionFolder(_ id: String) {
        if let questionFolder = realm.objects(QuestionFolder.self).filter(NSPredicate(format: "id = %@", id)).first {
            try? realm.write {
                realm.delete(questionFolder)
            }
        }
    }
    
    // MARK: 문제 추가하기
    func createdQuestion(id: String, addQuestion: String) {
        if let questionFolder = realm.objects(QuestionFolder.self).filter(NSPredicate(format: "id = %@", id)).first {
            let question = Question()
            question.question = addQuestion
            question.id = UUID().uuidString
            try? realm.write {
                questionFolder.questionList.append(question)
            }
        }
    }
    
    // MARK: 문제 수정하기
    func updateQuestion(updateQuestion: Question) {
        if let question = realm.objects(Question.self).filter(NSPredicate(format: "id = %@", updateQuestion.id)).first {
            try? realm.write {
                question.question = updateQuestion.question
                question.answer = updateQuestion.answer
            }
        }
    }
        
    // MARK: 문제 삭제하기
    func deleteQuestion(_ id: String) {
        if let question = realm.objects(Question.self).filter(NSPredicate(format: "id = %@", id)).first {
            try? realm.write {
                realm.delete(question)
            }
        }
    }
    
    // MARK: 문제 불러오기
    func loadQuestion(folderId: String, question: String, answer: String) {
        if let questionFolder = realm.objects(QuestionFolder.self).filter(NSPredicate(format: "id = %@", folderId)).first {
                let addQuestion = Question()
                addQuestion.id = UUID().uuidString
                addQuestion.question = question
                addQuestion.answer = answer
                try? realm.write {
                    questionFolder.questionList.append(addQuestion)
            }
        }
    }
    
    func removeAll() {
        try? realm.write {
            realm.deleteAll()
        }
    }
}
 
