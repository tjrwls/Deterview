//
//  CustomDetailViewController.swift
//  Deterview
//
//  Created by MIJU on 2022/12/12.
//

import UIKit

class CustomDetailViewController: UIViewController {

    @IBOutlet weak var answerText: UILabel!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextView!

    var questionStore: QuestionFolderStore? = nil
    var isShowingAnswerTextField: Bool = false
    var isShowingAnswerText: Bool = false
    var question: Question? = nil
    
    lazy var editButton: UIBarButtonItem = {
        UIBarButtonItem(title: "편집", style: .done, target: self, action: #selector(tapEditBtn))
    }()
    lazy var saveButton: UIBarButtonItem = {
        UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(tapSaveBtn))
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButton
        
        questionText.text = question?.question
        questionText.font = .systemFont(ofSize: 24)
        questionText.setLineSpacing(spacing: 4)

        questionTextField.font = .systemFont(ofSize: 24)
        questionTextField.isHidden = true
        questionTextField.borderStyle = .none
        
        answerText.numberOfLines = 0
        answerText.sizeToFit()
        answerText.text = question?.answer
        answerText.font = .systemFont(ofSize: 17)
        answerText.setLineSpacing(spacing: 4)
        
        answerTextField.layer.isHidden = true
        answerTextField.font = .systemFont(ofSize: 17)
     
        self.navigationItem.title = "Question"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    @objc func tapEditBtn() {
        answerText.layer.isHidden.toggle()
        answerTextField.text = answerText.text
        answerTextField.layer.isHidden.toggle()
        answerTextField.becomeFirstResponder()
        self.navigationItem.rightBarButtonItem = self.saveButton
        
        questionText.isHidden.toggle()
        questionTextField.text = questionText.text
        questionTextField.isHidden.toggle()
        if !(UIDevice.current.orientation.isLandscape) {
            answerTextField.textContainerInset = UIEdgeInsets(top: 13, left: 17, bottom: 260, right: 20)
        } else {
            answerTextField.textContainerInset = UIEdgeInsets(top: 13, left: 17, bottom: 180, right: 20)
        }
//        UIView.animate( // 키보드 올라올 때
//            withDuration: 0.4
//            , animations: {
//                self.view.transform = CGAffineTransform(translationX: 0, y: -150) // view 위로 밀림
//            }
//        )
    }
    
    @objc func tapSaveBtn() {
        answerText.layer.isHidden.toggle()
        answerTextField.layer.isHidden.toggle()
        answerText.text = answerTextField.text
        self.navigationItem.rightBarButtonItem = self.editButton
        questionText.text = questionTextField.text
        questionText.isHidden.toggle()
        questionTextField.isHidden.toggle()
        answerTextField.resignFirstResponder()
        
        let updateQuestion = Question()
        updateQuestion.id = question?.id ?? ""
        updateQuestion.answer = answerTextField.text ?? ""
        updateQuestion.question = questionTextField.text ?? ""
        questionStore?.updateQuestion(updateQuestion: updateQuestion)
        UIView.animate( // 키보드 내려올 때
            withDuration: 0.1
            , animations: {
                self.view.transform = CGAffineTransform(translationX: 0, y: 0) // view 제자리
            }
        )
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.view.transform = CGAffineTransform(translationX: 0, y: 0)
        if !(UIDevice.current.orientation.isLandscape) {
            answerTextField.textContainerInset = UIEdgeInsets(top: 13, left: 17, bottom: 260, right: 20)
        } else {
            answerTextField.textContainerInset = UIEdgeInsets(top: 13, left: 17, bottom: 180, right: 20)
        }
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
