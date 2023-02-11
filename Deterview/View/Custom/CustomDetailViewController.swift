//
//  CustomDetailViewController.swift
//  Deterview
//
//  Created by MIJU on 2022/12/12.
//

import UIKit

final class CustomDetailViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var answerText: UILabel!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var questionTextField: UITextView!
    @IBOutlet weak var answerTextField: UITextView!
    
    private var isShowingAnswerTextField: Bool = false
    private var isShowingAnswerText: Bool = false
    private var isEmptyAnswerText: Bool = false
    
    var questionStore: QuestionFolderStore?
    var question: Question?
    
//    lazy var editButton: UIBarButtonItem =
//        UIBarButtonItem(title: "편집", style: .done, target: self, action: #selector(tapEditBtn))
//   
//    lazy var saveButton: UIBarButtonItem = {
//        UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(tapSaveBtn))
//    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        isEmptyAnswerText = question?.answer == ""
        configureUI()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.view.transform = CGAffineTransform(translationX: 0, y: 0)
        if Int(self.view.window?.windowScene?.screen.bounds.width ?? 0) < Int(view.window?.windowScene?.screen.bounds.height ?? 0) {
            answerTextField.textContainerInset = UIEdgeInsets(top: 13, left: 17, bottom: 260, right: 20)
        } else {
            answerTextField.textContainerInset = UIEdgeInsets(top: 13, left: 17, bottom: 180, right: 20)
        }
    }
    
    // MARK: - Methods
    private func configureUI() {
        configureNavigation()
        configureAnswerText()
        configureAnswerTextField()
        configureQuestionText()
        configureQuestionTextField()
    }
    
    private func configureNavigation() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "편집", style: .done, target: self, action: #selector(tapEditBtn))
        self.navigationItem.title = "Question"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func configureAnswerText() {
        answerText.numberOfLines = 0
        answerText.sizeToFit()
        answerText.text = isEmptyAnswerText ? "답변을 입력해주세요." : question?.answer
        answerText.font = .systemFont(ofSize: 17)
        answerText.textColor = isEmptyAnswerText ? .lightGray : .black
        answerText.setLineSpacing(spacing: 4)
    }
    
    private func configureAnswerTextField() {
        answerTextField.layer.isHidden = true
        answerTextField.font = .systemFont(ofSize: 17)
    }
    
    private func configureQuestionText() {
        questionText.text = question?.question
        questionText.font = .systemFont(ofSize: 24)
        questionText.numberOfLines = 0
        questionText.setLineSpacing(spacing: 4.2)
    }
    
    private func configureQuestionTextField() {
        questionTextField.font = .systemFont(ofSize: 24)
        questionTextField.isHidden = true
        questionTextField.textContainerInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    @objc func tapEditBtn() {
        answerText.layer.isHidden.toggle()
        answerTextField.text = isEmptyAnswerText ? "" : answerText.text
        answerTextField.layer.isHidden.toggle()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(tapSaveBtn))
        questionText.isHidden.toggle()
        questionTextField.text = questionText.text
        questionTextField.becomeFirstResponder()
        questionTextField.isHidden.toggle()
        
        if Int(self.view.window?.windowScene?.screen.bounds.width ?? 0) < Int(view.window?.windowScene?.screen.bounds.height ?? 0) {
            answerTextField.textContainerInset = UIEdgeInsets(top: 13, left: 17, bottom: 260, right: 20)
        } else {
            answerTextField.textContainerInset = UIEdgeInsets(top: 13, left: 17, bottom: 180, right: 20)
        }
    }
    
    @objc func tapSaveBtn() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "편집", style: .done, target: self, action: #selector(tapEditBtn))
        isEmptyAnswerText = answerTextField.text == ""
        
        answerText.text = isEmptyAnswerText ? "답변을 입력해주세요." : answerTextField.text
        answerText.layer.isHidden.toggle()
        answerText.textColor = isEmptyAnswerText ? .lightGray : .black
        
        answerTextField.layer.isHidden.toggle()
        answerTextField.resignFirstResponder()
        
        questionText.text = questionTextField.text
        questionText.isHidden.toggle()
        
        questionTextField.isHidden.toggle()
        questionTextField.resignFirstResponder()
        
        let updateQuestion = Question()
        updateQuestion.id = question?.id ?? ""
        updateQuestion.answer = answerTextField.text ?? ""
        updateQuestion.question = questionTextField.text ?? ""
        
        questionStore?.updateQuestion(updateQuestion: updateQuestion)
        
        UIView.animate( // 키보드 내려올 때
            withDuration: 0.1,
            animations: {
                self.view.transform = CGAffineTransform(translationX: 0, y: 0) // view 제자리
            }
        )
    }
}
