//
//  CustomViewController.swift
//  Deterview
//
//  Created by MIJU on 2022/12/12.
//

import UIKit

enum Mode {
    case view
    case select
}

class CustomViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var questionStore: QuestionFolderStore = QuestionFolderStore()

    var dictionarySelectedIndexPath: [IndexPath : Bool] = [:]
    var editMode: Mode = .view {
        didSet{
            switch editMode {
            case .view:
                dictionarySelectedIndexPath.removeAll()
                self.customCollectionView.allowsMultipleSelection = false
            case .select:
                self.customCollectionView.allowsMultipleSelection = true
            }
        }
    }
    
    @IBOutlet weak var customCollectionView: UICollectionView!
    lazy var menuBtn: UIBarButtonItem = {
        UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .done, target: self, action: #selector(tapMenuBtn))
    }()
    
    lazy var cancelBtn: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(tapCancelBtn))
    }()
    
    lazy var deleteBtn: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(tapDeleteBtn))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemGray6
        customCollectionView.delegate = self
        customCollectionView.dataSource = self
        customCollectionView.backgroundColor = UIColor.systemGray6
        customCollectionView.allowsMultipleSelection = false
        
        menuBtn.tintColor = .black
        self.navigationItem.rightBarButtonItem = self.menuBtn
        questionStore.readQuestionFolder()
    }
    
    // 섹션에 표시 할 셀 갯수를 묻는 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionStore.customQuestionFolders.count
    }
    // 콜렉션 뷰의 특정 인덱스에서 표시할 셀을 요청하는 메서드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCardListCell", for: indexPath) as?
                CustomCardListCell else {
            return UICollectionViewCell()
        }
        
        cell.layer.cornerRadius = 5
        cell.moveToListMethod = {
            let index = indexPath.row
            guard let vc = self.storyboard?.instantiateViewController(identifier: "CustomListViewController") as? CustomListViewController else { return }
//            vc.questionList = Array(self.questionStore.questionFolderStore[index].questionList)
            vc.questionStore = self.questionStore
            vc.questionFolder = self.questionStore.customQuestionFolders[index]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.moveToQuizMethod = {
            let index = indexPath.row
            if self.questionStore.customQuestionFolders[index].questionList.isEmpty {
                let alert = UIAlertController(title: "문제풀기", message: "풀 수 있는 문제가 없습니다.\n문제를 추가해주세요.", preferredStyle: .alert)
                let retry = UIAlertAction(title: "확인", style: .default)
                alert.addAction(retry)
                self.present(alert, animated: false)
            } else {
                guard let vc = self.storyboard?.instantiateViewController(identifier: "QuizViewController") as? QuizViewController else { return }
                vc.questionList = self.questionStore.customQuestionFolders[index].questionList
                vc.folderName = self.questionStore.customQuestionFolders[index].folderName
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        cell.editFolderNameMethod = {
            let index = indexPath.row
            guard let vc = self.storyboard?.instantiateViewController(identifier: "EditingFolderNameViewController") as? EditingFolderNameViewController else { return }
            
            vc.questionFolder = self.questionStore.customQuestionFolders[index]
            vc.questionStore = self.questionStore
            vc.viewController = self
            self.present(vc, animated: true)
        }
        
        cell.editFolderNameBtn.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        cell.editFolderNameBtn.tintColor = UIColor(named: "AccentColor")
        cell.editFolderNameBtn.imageView?.contentMode = .scaleAspectFit
        
        let cellInfo = questionStore.customQuestionFolders[indexPath.row]
        cell.update(info: cellInfo)
        
        switch editMode {
        case .view :
            cell.checkMark.isHidden = true
            cell.editView.isHidden = true
            cell.editFolderNameBtn.isHidden = true
        case .select :
            cell.editView.isHidden = false
            cell.checkMark.isHidden = false
            cell.editFolderNameBtn.isHidden = false
        }
        
        return cell
    }
    
//셀이 선택되었을 때
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch editMode {
        case .view:
            break
        case .select:
            dictionarySelectedIndexPath[indexPath] = true
//            if dictionarySelectedIndexPath[indexPath] ?? false {
//                dictionarySelectedIndexPath[indexPath] = false
//            } else {
//                dictionarySelectedIndexPath[indexPath] = true
//            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if let flowLayout = self.customCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.invalidateLayout()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UICollectionView.performWithoutAnimation {
            self.customCollectionView.reloadSections([0])
        }
    }
    
    @objc func tapMenuBtn() {
        showActionSheet()
    }
    @objc func tapCancelBtn(){
        self.navigationItem.rightBarButtonItem = self.menuBtn
        self.navigationItem.leftBarButtonItem = nil
        self.editMode = .view
        UIView.performWithoutAnimation {   
            self.customCollectionView.reloadSections([0])
        }
    }
    @objc func tapDeleteBtn(){
        let alert = UIAlertController(title: "완료", message: "문풀완", preferredStyle: .alert)
        let close = UIAlertAction(title: "취소", style: .default) {_ in
            self.navigationController?.popViewController(animated: true)
        }
        let retry = UIAlertAction(title: "삭제", style: .destructive) {_ in
            for (key,value) in self.dictionarySelectedIndexPath {
                if value {
                    let id: String = self.questionStore.customQuestionFolders[key.row].id
                    self.questionStore.deleteQuestionFolder(id)
                }
            }
            self.dictionarySelectedIndexPath.removeAll()
            self.questionStore.readQuestionFolder()
            self.customCollectionView.reloadSections([0])
            
            self.navigationItem.rightBarButtonItem = self.menuBtn
            self.navigationItem.leftBarButtonItem = nil
            self.editMode = .view
        }
        alert.addAction(close)
        alert.addAction(retry)
        self.present(alert, animated: false)
    }
    
    func showActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let first = UIAlertAction(title: "폴더 추가하기", style: .default) { action in
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddingFolderViewController") as? AddingFolderViewController else { return }
            vc.modalPresentationStyle = .formSheet
            vc.viewController = self
            vc.questionStore = self.questionStore
            self.present(vc,animated: true)
        }
        let second = UIAlertAction(title: "편집하기", style: .default) { action in
            self.navigationItem.rightBarButtonItem = self.cancelBtn
            self.navigationItem.leftBarButtonItem = self.deleteBtn
            self.editMode = .select
            UIView.performWithoutAnimation {
                self.customCollectionView.reloadSections([0])
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in }
        actionSheet.addAction(first)
        actionSheet.addAction(second)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    @IBAction func tapEditImage(_ sender: Any) {
        print("tap")
    }
}

extension CustomViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (Int(view.window?.windowScene?.screen.bounds.width ?? 0) > Int(view.window?.windowScene?.screen.bounds.height ?? 0)) {
            return CGSize(width: collectionView.bounds.width / 2 - 20, height: 100)
        } else {
            return CGSize(width: collectionView.bounds.width - 10, height: 100)
        }
    }
}

class CustomCardListCell: UICollectionViewCell {
    @IBOutlet weak var cardBtn: UIButton!
    @IBOutlet weak var movequizBtn: UIButton!
    @IBOutlet weak var countofQuestion: UILabel!
    @IBOutlet weak var forderNameText: UILabel!
    @IBOutlet weak var checkMark: UIImageView!
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var editFolderNameImage: UIImageView!
    
    @IBAction func tapCardBtn(_ sender: Any) {
        moveToListMethod?()
    }
    @IBAction func tapQuizBtn(_ sender: Any) {
        moveToQuizMethod?()
    }
    
    @IBOutlet weak var editFolderNameBtn: UIButton!
    @IBAction func tapEditFolderNameBtn(_ sender: Any) {
        editFolderNameMethod?()
    }
    var moveToListMethod: (() -> Void)?
    var moveToQuizMethod: (() -> Void)?
    var editFolderNameMethod: (() -> Void)?
    var questionCount: Int = 0
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                checkMark.image = UIImage(systemName: "checkmark.circle")
            } else {
                checkMark.image = UIImage(systemName: "circle")
            }
        }
    }
    
    func update(info: QuestionFolder) {
        forderNameText.text = info.folderName
        forderNameText.font = .systemFont(ofSize: 30)
        cardBtn.backgroundColor = UIColor.white
        cardBtn.layer.cornerRadius = 5
        cardBtn.layer.shadowOpacity = 0.3
        cardBtn.layer.shadowRadius = 20
        
        countofQuestion.text = "\(info.questionList.count)개의 질문"
        
        checkMark.image = UIImage(systemName: "circle")
        checkMark.tintColor = .gray
        
        editView.layer.opacity = 0.1
        questionCount = info.questionList.count
        
        movequizBtn.backgroundColor = UIColor(.mainColor)
        movequizBtn.setTitleColor(.white, for: .normal)
        movequizBtn.layer.cornerRadius = 5
        
    }
}
