////
////  QuestionStore.swift
////  Deterview
////
////  Created by MIJU on 2022/12/13.
////
//
import Foundation
import RealmSwift

class QuestionFolderStore {
    var questionFolderStore: [QuestionFolder2] = []
    
    let realm = try! Realm()
    
    func createdQuestionFolder(_ questionFolder: QuestionFolder) {
        let createFolder = QuestionFolder2()
        createFolder.id = UUID().uuidString
        createFolder.folderName = questionFolder.folderName
        try! self.realm.write {
            self.realm.add(createFolder)
        }
    }
    
    func readQuestionFolder(){
        let folderData = self.realm.objects(QuestionFolder2.self)
        questionFolderStore = Array(folderData)
    }
    
    func updateQuestionFolder(){
        if let questionFolder = realm.objects(QuestionFolder2.self).filter(NSPredicate(format: "id = %@", "64B1B0AD-4826-4D08-9060-3F049711ECEA")).first{
            let question = Question2()
            try! realm.write{
                questionFolder.folderName = ""
                questionFolder.questionList.append(question)
                self.questionFolderStore.append(questionFolder)
            }
        }
    }
    
    func deleteQuestionFolder(){
        if let questionFolder = realm.objects(QuestionFolder2.self).filter(NSPredicate(format: "id = %@", "E0C3CC28-12C4-411D-AF20-56A89B158713")).first{
            try! realm.write {
                realm.delete(questionFolder)
            }
        }
    }
}
 
