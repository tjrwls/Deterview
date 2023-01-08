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
    var questionFolderStore: [QuestionFolder] = []
    
    let realm = try! Realm()
    
    func createdQuestionFolder(_ questionFolder: QuestionFolder) {
        let createFolder = QuestionFolder()
        createFolder.id = UUID().uuidString
        createFolder.folderName = questionFolder.folderName
        createFolder.category = "Custom"
        try! self.realm.write {
            self.realm.add(createFolder)
        }
    }
    
    func readQuestionFolder(){
        let folderData = self.realm.objects(QuestionFolder.self)
        questionFolderStore = Array(folderData)
    }
    
    func updateQuestionFolder(id: String, name: String){
        if let questionFolder = realm.objects(QuestionFolder.self).filter(NSPredicate(format: "id = %@", id)).first{
            try! realm.write{
                questionFolder.folderName = name
            }
        }
    }
    
    func deleteQuestionFolder(_ id: String){
        if let questionFolder = realm.objects(QuestionFolder.self).filter(NSPredicate(format: "id = %@", id)).first{
            try! realm.write {
                realm.delete(questionFolder)
            }
        }
    }
    
    func createdQuestion(id: String, addQuestion: String){
        if let questionFolder = realm.objects(QuestionFolder.self).filter(NSPredicate(format: "id = %@", id)).first{
            let question = Question()
            question.question = addQuestion
            question.id = UUID().uuidString
            try! realm.write{
                questionFolder.questionList.append(question)
            }
        }
    }
    
    func deleteQuestion(_ id: String){
        if let question = realm.objects(Question.self).filter(NSPredicate(format: "id = %@", id)).first{
            print(question)
            try! realm.write {
                realm.delete(question)
            }
        }
    }
}
 
