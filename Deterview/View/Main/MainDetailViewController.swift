//
//  MainDetailViewController.swift
//  Deterview
//
//  Created by MIJU on 2022/12/03.
//

import UIKit

final class MainDetailViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var answerText: UILabel!
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var answerTextField: UITextView!
    
    private var isShowingAnswerTextField: Bool = false
    private var isShowingAnswerText: Bool = false
    private var isEmptyAnswerText: Bool = false
    
    var questionStore: QuestionFolderStore?
    var question: Question?
    
    lazy var editButton: UIBarButtonItem = {
        UIBarButtonItem(title: "편집", style: .done, target: self, action: #selector(tapEditBtn))
    }()
    lazy var saveButton: UIBarButtonItem = {
        UIBarButtonItem(title: "저장", style: .done, target: self, action: #selector(tapSaveBtn))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Methods
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if Int(self.view.window?.windowScene?.screen.bounds.width ?? 0) < Int(view.window?.windowScene?.screen.bounds.height ?? 0) {
            answerTextField.textContainerInset = UIEdgeInsets(top: 13, left: 17, bottom: 260, right: 20)
        } else {
            answerTextField.textContainerInset = UIEdgeInsets(top: 13, left: 17, bottom: 180, right: 20)
        }
    }
    
    private func configureUI() {
        isEmptyAnswerText = question?.answer == ""
        configureQuestionText()
        configureAnswerText()
        configureTextField()
        configureNavigationItem()
    }
    
    private func configureQuestionText() {
        questionText.numberOfLines = 0
        questionText.text = question?.question
        questionText.font = .systemFont(ofSize: 20)
    }
    
    private func configureAnswerText() {
        answerText.numberOfLines = 0
        answerText.sizeToFit()
        answerText.text = isEmptyAnswerText ? "답변을 입력해주세요." : question?.answer
        answerText.textColor = isEmptyAnswerText ? .lightGray : .black
        answerText.font = .systemFont(ofSize: 17)
        answerText.setLineSpacing(spacing: 4)
    }
   
    private func configureTextField() {
        answerTextField.layer.isHidden = true
        answerTextField.font = .systemFont(ofSize: 17)
    }
    
    private func configureNavigationItem() {
        self.navigationItem.rightBarButtonItem = self.editButton
        self.navigationItem.title = "Question"
        navigationItem.largeTitleDisplayMode = .never
    }
    
    @objc func tapEditBtn() {
        self.navigationItem.rightBarButtonItem = self.saveButton
        
        answerText.layer.isHidden.toggle()
        answerTextField.text = isEmptyAnswerText ? "" : answerText.text
        answerTextField.layer.isHidden.toggle()
        answerTextField.becomeFirstResponder()
        
        if Int(self.view.window?.windowScene?.screen.bounds.width ?? 0) < Int(view.window?.windowScene?.screen.bounds.height ?? 0) {
            answerTextField.textContainerInset = UIEdgeInsets(top: 13, left: 17, bottom: 260, right: 20)
        } else {
            answerTextField.textContainerInset = UIEdgeInsets(top: 13, left: 17, bottom: 180, right: 20)
        }
    }
    
    @objc func tapSaveBtn() {
        isEmptyAnswerText = answerTextField.text == ""
        self.navigationItem.rightBarButtonItem = self.editButton
        
        answerText.layer.isHidden.toggle()
        answerText.text = isEmptyAnswerText ? "답변을 입력해주세요." : answerTextField.text
        answerText.textColor = isEmptyAnswerText ? .lightGray : .black
        
        answerTextField.layer.isHidden.toggle()
        answerTextField.resignFirstResponder()
        
        let updateQuestion = Question()
        updateQuestion.id = question?.id ?? ""
        updateQuestion.answer = answerTextField.text ?? ""
        updateQuestion.question = questionText.text ?? ""
        questionStore?.updateQuestion(updateQuestion: updateQuestion)
    }
}
