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
    // MARK: - Properties
    var mainQuestionFolders: [QuestionFolder] = []
    var customQuestionFolders: [QuestionFolder] = []
    let realm = try! Realm()
    
    // MARK: - Methods
    func createdQuestionFolder(_ questionFolder: QuestionFolder) {
        let createFolder = QuestionFolder()
        createFolder.id = UUID().uuidString
         createFolder.folderName = questionFolder.folderName
        createFolder.category = "Custom"
        try? self.realm.write {
            self.realm.add(createFolder)
        }
    }
    
    func readQuestionFolder() {
        let folderData = self.realm.objects(QuestionFolder.self)
        mainQuestionFolders = Array(folderData).filter { $0.category == "Main" }
        customQuestionFolders = Array(folderData).filter { $0.category == "Custom" }
    }
    
    func updateQuestionFolder(id: String, name: String) {
        if let questionFolder = realm.objects(QuestionFolder.self).filter(NSPredicate(format: "id = %@", id)).first {
            try? realm.write {
                questionFolder.folderName = name
            }
        }
    }
    
    func deleteQuestionFolder(_ id: String) {
        if let questionFolder = realm.objects(QuestionFolder.self).filter(NSPredicate(format: "id = %@", id)).first {
            try? realm.write {
                realm.delete(questionFolder)
            }
        }
    }
    
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
    
    func updateQuestion(updateQuestion: Question) {
        if let question = realm.objects(Question.self).filter(NSPredicate(format: "id = %@", updateQuestion.id)).first {
            try? realm.write {
                question.question = updateQuestion.question
                question.answer = updateQuestion.answer
            }
        }
    }
        
    func deleteQuestion(_ id: String) {
        if let question = realm.objects(Question.self).filter(NSPredicate(format: "id = %@", id)).first {
            try? realm.write {
                realm.delete(question)
            }
        }
    }
    
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
 
