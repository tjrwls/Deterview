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
    
    @IBOutlet weak var folderNameTextField: UITextField!
    @IBOutlet weak var cancleBtn: UIButton!
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var saveFolderNameBtn: UIButton!
    @IBOutlet weak var guideText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        modalView.layer.cornerRadius = CGFloat(10)
        guideText.text = "폴더 이름을 입력해주세요"
        cancleBtn.setTitle("취소", for: .normal)
        saveFolderNameBtn.setTitle("완료", for: .normal)
        saveFolderNameBtn.tintColor = UIColor(.mainColor)
        
//        print("\(self.presentedViewController)")
//        print("\(self.presentingViewController)")
//        print("\(self.presentingViewController?.viewcont ?? CustomViewController())")
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
        questionStore?.createdQuestionFolder(QuestionFolder(folderName: "\(folderNameTextField!.text ?? "")", questionList: []))
        questionStore?.readQuestionFolder()
//        print("1")
//        guard let vc = self.presentingViewController?.popoverPresentationController as? CustomViewController else { return }
//        print("2")
        
        self.dismiss(animated: true) {
//            vc.CustomCollectionView.reloadData()
//            print("3")
            self.viewController?.CustomCollectionView.reloadData()
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

}
