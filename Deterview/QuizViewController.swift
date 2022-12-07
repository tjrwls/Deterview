//
//  QuizViewController.swift
//  Deterview
//
//  Created by MIJU on 2022/12/05.
//

import UIKit

class QuizViewController: UIViewController {
    var questionList: [Question] = []
    var questionArr: [Question] = []
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var answerText: UILabel!
    @IBOutlet weak var nextQuizBtn: UIButton!
    @IBOutlet weak var placeholderText: UILabel!
    @IBOutlet weak var answerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionText.text = questionList[0].question
        answerText.text = questionList[0].answer
        answerText.layer.isHidden = true
        placeholderText.isHidden = false
        questionArr = questionList
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapAnswerView(_ sender: UIGestureRecognizer) {
        answerText.isHidden.toggle()
        placeholderText.isHidden.toggle()
    }
    
    @IBAction func nextQuizBtn(_ sender: Any) {
        let question = questionArr.randomElement()
        
        if questionArr.isEmpty { // 문제 다 풀었으면
            let alert = UIAlertController(title: "완료", message: "문풀완", preferredStyle: .alert)
            let close = UIAlertAction(title: "나가기", style: .cancel) {_ in
                self.navigationController?.popViewController(animated: true)
            }
            let retry = UIAlertAction(title: "다시 풀기", style: .default) {_ in
                self.questionArr = self.questionList
                self.generateRandomQuestion()
            }
            alert.addAction(close)
            alert.addAction(retry)
            
            self.present(alert, animated: false)
        }
        questionText.text = question?.question
        answerText.text = question?.answer
       
        questionArr.removeAll(where: {
            $0.id == question?.id
        })
        
    }
    
    func generateRandomQuestion() {
        let question = self.questionArr.randomElement()
        self.questionText.text = question?.question
        self.answerText.text = question?.answer
        self.questionArr.removeAll(where: {
            $0.id == question?.id
        })
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
