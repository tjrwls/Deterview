//
//  EditingFolderNameViewController.swift
//  Deterview
//
//  Created by 조석진 on 2022/12/29.
//

import UIKit

class EditingFolderNameViewController: UIViewController {
    var questionStore: QuestionFolderStore? = nil
    var viewController: CustomViewController? = nil
    var questionFolder: QuestionFolder? = nil
    var folderNameTextLength: Int {
        folderNameTextField.text?.count ?? 0
    }

    @IBOutlet weak var folderNameTextField: UITextField!
    @IBOutlet weak var cancleBtn: UIButton!
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var saveFolderNameBtn: UIButton!
    @IBOutlet weak var guideText: UILabel!
    @IBOutlet weak var limitTextLengthMessage: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        modalView.layer.cornerRadius = CGFloat(10)
        guideText.text = "폴더 이름을 입력해주세요"
        guideText.textAlignment = .center
        cancleBtn.setTitle("취소", for: .normal)
        
        saveFolderNameBtn.setTitle("완료", for: .normal)
        saveFolderNameBtn.layer.cornerRadius = 5
        saveFolderNameBtn.backgroundColor = UIColor(.mainColor)
        saveFolderNameBtn.setTitleColor(.white, for: .normal)
        saveFolderNameBtn.titleLabel?.font = .systemFont(ofSize: 16)
        
        limitTextLengthMessage.text = "1~9자 이내로 입력해주세요."
        limitTextLengthMessage.font = .systemFont(ofSize: 14)
        limitTextLengthMessage.textColor = .gray
        folderNameTextField.text = questionFolder?.folderName
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.folderNameTextField.becomeFirstResponder()
        UIView.animate( // 키보드 올라올 때
            withDuration: 0.1
            , animations: {
                if UIDevice.current.orientation.isLandscape{
                    self.view.transform = CGAffineTransform(translationX: 0, y: -150) // view 위로 밀림
                }else{
                    self.view.transform = CGAffineTransform(translationX: 0, y: -300)
                }
            })
    }
    // MARK: 뷰회전시 View 위치 재조정
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape{
            self.view.transform = CGAffineTransform(translationX: 0, y: -150)
        }else{
            self.view.transform = CGAffineTransform(translationX: 0, y: -300)
        }
    }

    @IBAction func tapSaveBtn(_ sender: Any) {
        questionStore?.updateQuestionFolder(id: questionFolder?.id ?? ""
                                            , name: folderNameTextField.text ?? "")
        questionStore?.readQuestionFolder()
        
        self.dismiss(animated: true) {
            UICollectionView.performWithoutAnimation {
                self.viewController?.customCollectionView.reloadSections([0])
            }
        }
    }
    
    @IBAction func tabCancleBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    @IBAction func textFieldEditingChanged(_ sender: Any) {
        if viewController != nil { // 폴더 추가일 경우
            if folderNameTextLength > 0 && folderNameTextLength < 10 {
                saveFolderNameBtn.isEnabled = true
                saveFolderNameBtn.backgroundColor = UIColor(.mainColor)
                saveFolderNameBtn.setTitleColor(.white, for: .normal)
                
            } else {
                saveFolderNameBtn.isEnabled = false
                saveFolderNameBtn.backgroundColor = UIColor(.customGray)
                saveFolderNameBtn.setTitleColor(.systemGray3, for: .normal)
            }
        } else { // 질문 추가일 경우
            if folderNameTextLength > 0  {
                saveFolderNameBtn.isEnabled = true
                saveFolderNameBtn.backgroundColor = UIColor(.mainColor)
                saveFolderNameBtn.setTitleColor(.white, for: .normal)
            } else {
                saveFolderNameBtn.isEnabled = false
                saveFolderNameBtn.backgroundColor = UIColor(.customGray)
                saveFolderNameBtn.setTitleColor(.systemGray3, for: .normal)
            }
        }
    }
}
