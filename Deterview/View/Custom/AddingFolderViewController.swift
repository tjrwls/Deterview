//
//  AddingFolderViewController.swift
//  Deterview
//
//  Created by MIJU on 2022/12/15.
//

import UIKit

final class AddingFolderViewController: UIViewController {
    @IBOutlet weak var folderNameTextField: UITextField!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var folderNameSaveBtn: UIButton!
    @IBOutlet weak var guideText: UILabel!
    @IBOutlet weak var limitTextLengthMessage: UILabel!
    
    var folderId: String?
    private var folderNameTextLength: Int {
        folderNameTextField.text?.count ?? 0
    }
    
    var questionStore: QuestionFolderStore?
    var customViewController: CustomViewController?
    var customListViewController: CustomListViewController?
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    /// 뷰생성시 키보드 밑 View 올리기
    override func viewWillAppear(_ animated: Bool) {
        self.folderNameTextField.becomeFirstResponder()
        UIView.animate( // 키보드 올라올 때
            withDuration: 0.1,
            animations: {
                if UIDevice.current.orientation.isLandscape {
                    self.view.transform = CGAffineTransform(translationX: 0, y: -150) // view 위로 밀림
                } else {
                    self.view.transform = CGAffineTransform(translationX: 0, y: -300)
                }
            })
    }
    
    /// 뷰회전시 View 위치 재조정
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            self.view.transform = CGAffineTransform(translationX: 0, y: -150)
        } else {
            self.view.transform = CGAffineTransform(translationX: 0, y: -300)
        }
    }
    
    // MARK: - Methods
    @IBAction func tapSaveBtn(_ sender: Any) {
        if customViewController != nil {
            let questionFolder: QuestionFolder = QuestionFolder()
            questionFolder.folderName = folderNameTextField.text ?? ""
            questionFolder.category = "Custom"
            questionStore?.createdQuestionFolder(questionFolder)
            questionStore?.readQuestionFolder()
            
            self.dismiss(animated: true) {
                UICollectionView.performWithoutAnimation {
                    self.customViewController?.customCollectionView.reloadSections([0])
                }
            }
        } else {
            questionStore?.createdQuestion(id: folderId ?? "", addQuestion: folderNameTextField.text ?? "")
            
            self.dismiss(animated: true) {
                UITableView.performWithoutAnimation {
                    self.customListViewController?.customListView.reloadData()
                }
            }
        }
    }
    
    @IBAction func tabCancelBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func textFieldEditingChanged(_ sender: Any) {
        if customViewController != nil { // 폴더 추가일 경우
            if folderNameTextLength > 0 && folderNameTextLength < 10 {
                folderNameSaveBtn.isEnabled = true
                folderNameSaveBtn.backgroundColor = UIColor(.mainColor)
                folderNameSaveBtn.setTitleColor(.white, for: .normal)
                
            } else {
                folderNameSaveBtn.isEnabled = false
                folderNameSaveBtn.backgroundColor = UIColor(.customGray)
                folderNameSaveBtn.setTitleColor(.systemGray3, for: .normal)
            }
        } else { // 질문 추가일 경우
            if folderNameTextLength > 0 {
                folderNameSaveBtn.isEnabled = true
                folderNameSaveBtn.backgroundColor = UIColor(.mainColor)
                folderNameSaveBtn.setTitleColor(.white, for: .normal)
            } else {
                folderNameSaveBtn.isEnabled = false
                folderNameSaveBtn.backgroundColor = UIColor(.customGray)
                folderNameSaveBtn.setTitleColor(.systemGray3, for: .normal)
            }
        }
    }
    
    private func configureUI() {
        modalView.layer.cornerRadius = CGFloat(10)
        guideText.textAlignment = .center
        cancelBtn.setTitle("취소", for: .normal)
        configureSaveFolderNameBtn()
        configureCheckingViewController()
    }
    
    private func configureCheckingViewController() {
        if customViewController != nil {
            configureAddingFolderUI()
        } else {
            configureAddingQuestionUI()
        }
    }
    
    private func configureAddingFolderUI() {
        guideText.text = "폴더 이름을 입력해주세요"
        limitTextLengthMessage.text = "1~9자 이내로 입력해주세요."
        limitTextLengthMessage.font = .systemFont(ofSize: 14)
        limitTextLengthMessage.textColor = .gray
    }
    
    private func configureAddingQuestionUI() {
        guideText.text = "질문을 입력해주세요."
        limitTextLengthMessage.text = ""
    }
    
    private func configureSaveFolderNameBtn() {
        folderNameSaveBtn.setTitle("완료", for: .normal)
        folderNameSaveBtn.backgroundColor = UIColor(.customGray)
        folderNameSaveBtn.setTitleColor(.systemGray3, for: .normal)
        folderNameSaveBtn.layer.cornerRadius = 5
        folderNameSaveBtn.titleLabel?.font = .systemFont(ofSize: 16)
        folderNameSaveBtn.isEnabled = false
    }
}
