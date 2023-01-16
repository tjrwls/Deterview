//
//  AddingFolderViewController.swift
//  Deterview
//
//  Created by MIJU on 2022/12/15.
//

import UIKit

class AddingFolderViewController: UIViewController {
    var questionStore: QuestionFolderStore? = nil
    var viewController: CustomViewController? = nil
    var customListViewController: CustomListViewController? = nil
    var folderId: String = ""
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
        modalView.layer.cornerRadius = CGFloat(10)
        if viewController != nil{
            guideText.text = "폴더 이름을 입력해주세요"
            limitTextLengthMessage.text = "1~9자 이내로 입력해주세요."
            limitTextLengthMessage.font = .systemFont(ofSize: 14)
            limitTextLengthMessage.textColor = .gray
            saveFolderNameBtn.isEnabled = false
        } else {
            guideText.text = "질문을 입력해주세요."
            limitTextLengthMessage.text = ""
            saveFolderNameBtn.isEnabled = false
        }
        guideText.textAlignment = .center
        cancleBtn.setTitle("취소", for: .normal)
        saveFolderNameBtn.setTitle("완료", for: .normal)
        saveFolderNameBtn.tintColor = UIColor(.mainColor)
    }
    
    // MARK: 뷰생성시 키보드 밑 View 올리기
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
        if viewController != nil {
            let questionFolder: QuestionFolder = QuestionFolder()
            questionFolder.folderName = folderNameTextField.text ?? ""
            questionFolder.category = "Custom"
            questionStore?.createdQuestionFolder(questionFolder)
            questionStore?.readQuestionFolder()
            self.dismiss(animated: true) {
                UICollectionView.performWithoutAnimation {
                    self.viewController?.customCollectionView.reloadSections([0])
                }
            }
        } else {
            questionStore?.createdQuestion(id: folderId, addQuestion: folderNameTextField.text ?? "")
            self.dismiss(animated: true) {
                UITableView.performWithoutAnimation {
                    self.customListViewController?.customListView.reloadData()
                }
            }
        }
    }
    
    @IBAction func tabCancleBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func textFieldEditingChanged(_ sender: Any) {
        if viewController != nil {
            if folderNameTextLength > 0 && folderNameTextLength < 10 {
                saveFolderNameBtn.isEnabled = true
            } else { saveFolderNameBtn.isEnabled = false }
        } else {
            if folderNameTextLength > 0  {
                saveFolderNameBtn.isEnabled = true
            } else { saveFolderNameBtn.isEnabled = false }
        }
        
    }
    
//    @objc func textFieldDidChange(_ textField: UITextField) {
//
//    }

}
