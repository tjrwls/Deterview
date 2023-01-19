//
//  QuizViewController.swift
//  Deterview
//
//  Created by MIJU on 2022/12/05.
//

import UIKit
import RealmSwift

class QuizViewController: UIViewController {
    var questionList: List<Question> = List<Question>()
    var questionArr: [Question] = []
    var folderName: String = ""
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var answerText: UILabel!
    @IBOutlet weak var nextQuizBtn: UIButton!
    @IBOutlet weak var placeholderText: UILabel!
    @IBOutlet weak var answerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionText.numberOfLines = 0
        questionText.font = .systemFont(ofSize: 24)
        
        answerText.layer.isHidden = true
        answerText.font = .systemFont(ofSize: 17)
        answerText.numberOfLines = 0
        answerText.setLineSpacing(spacing: 5)
        
        placeholderText.isHidden = false
        placeholderText.font = .systemFont(ofSize: 22)
        placeholderText.text = "터치시 작성하신 답이 보입니다."
        
        nextQuizBtn.layer.cornerRadius = 5
        nextQuizBtn.setFontStyle(size: 20, weight: .bold)
        nextQuizBtn.backgroundColor = UIColor(named: "mainColor")
        nextQuizBtn.tintColor = .white
        
        questionArr = Array(questionList)
        print("questionList \(questionList)")
        navigationItem.title = folderName
        navigationItem.largeTitleDisplayMode = .never

        generateRandomQuestion()
    }
    
    @IBAction func tapAnswerView(_ sender: UIGestureRecognizer) {
        answerText.isHidden.toggle()
        placeholderText.isHidden.toggle()
    }
    
    @IBAction func nextQuizBtn(_ sender: Any) {
        if questionArr.isEmpty { // 문제 다 풀었으면
            let alert = UIAlertController(title: "완료", message: "문풀완", preferredStyle: .alert)
            let close = UIAlertAction(title: "나가기", style: .cancel) {_ in
                self.navigationController?.popViewController(animated: true)
            }
            let retry = UIAlertAction(title: "다시 풀기", style: .default) {_ in
                self.questionArr = Array(self.questionList)
                self.generateRandomQuestion()
            }
            alert.addAction(close)
            alert.addAction(retry)
            
            self.present(alert, animated: false)
        } else {
            generateRandomQuestion()
        }
    }
    
    func generateRandomQuestion() {
        if !questionArr.isEmpty {
            let question = self.questionArr.randomElement()
            self.questionText.text = question?.question
            self.answerText.text = question?.answer
            self.questionArr.remove(at: questionArr.firstIndex(where: {
                $0.id == question?.id
            }) ?? 0)
        }
    }
}
