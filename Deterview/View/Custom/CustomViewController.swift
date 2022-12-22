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

protocol SelectModeDelegate {
    func setSelectMode()
}

extension CustomCardListCell : SelectModeDelegate {
    func setSelectMode() {
        checkMark.isHidden = false
    }
}

class CustomViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var questionStore: QuestionFolderStore = QuestionFolderStore()
    var selectDelegate: SelectModeDelegate?
    var editMode: Mode = .view {
        didSet{
            switch editMode {
            case .view:
                self.CustomCollectionView.allowsMultipleSelection = false
            case .select:
                self.CustomCollectionView.allowsMultipleSelection = true
            }
        }
    }
    // TODO: 소문자로 수정
    @IBOutlet weak var CustomCollectionView: UICollectionView!
    lazy var menuBtn: UIBarButtonItem = {
        UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .done, target: self, action: #selector(tapMenuBtn))
    }()
    
    lazy var cancleBtn: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(tapCancleBtn))
    }()
    
    lazy var deleteBtn: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(tapDeleteBtn))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemGray6
        CustomCollectionView.delegate = self
        CustomCollectionView.dataSource = self
        CustomCollectionView.backgroundColor = UIColor.systemGray6
        self.navigationItem.rightBarButtonItem = self.menuBtn
        menuBtn.tintColor = .black
        CustomCollectionView.allowsMultipleSelection = true
        questionStore.readQuestionFolder()
        self.CustomCollectionView.allowsMultipleSelection = false
        print("viewDidLoad")
        
    }
    // 섹션에 표시 할 셀 갯수를 묻는 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionStore.questionFolderStore.count
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
            vc.questionList = Array(self.questionStore.questionFolderStore[index].questionList)
            vc.folderName = self.questionStore.questionFolderStore[index].folderName
            self.navigationController?.pushViewController(vc, animated: true)
        }
        cell.moveToQuizMethod = {
            let index = indexPath.row
            guard let vc = self.storyboard?.instantiateViewController(identifier: "QuizViewController") as? QuizViewController else { return }
            //            vc.questionList = self.questionFolders[index].questionList
            //            vc.folderName = self.questionFolders[index].folderName
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let cellInfo = questionStore.questionFolderStore[indexPath.row]
        cell.update(info: cellInfo)
        switch editMode {
        case .view :
            cell.checkMark.isHidden = true
            cell.editView.isHidden = true
        case .select :
            cell.editView.isHidden = false
            cell.checkMark.isHidden = false
        }
        return cell
    }
    
//셀이 선택되었을 때
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if let flowLayout = self.CustomCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.invalidateLayout() // 현재 layout을 무효화하고 layout 업데이트를 작동
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        UICollectionView.performWithoutAnimation {
            self.CustomCollectionView.reloadSections([0])
            print("1")
        }
        self.CustomCollectionView.reloadData()
//         viewWillAppear에서 호출시 크래쉬가 자주 날수 있다. View 생성전에 호출시 문제가 생길 수 있다.
    }
    
    @objc func tapMenuBtn() {
        showActionSheet()
    }
    @objc func tapCancleBtn(){
        self.navigationItem.rightBarButtonItem = self.menuBtn
        self.navigationItem.leftBarButtonItem = nil
        self.editMode = .view
        self.CustomCollectionView.reloadSections([0])
    }
    @objc func tapDeleteBtn(){
        self.navigationItem.rightBarButtonItem = self.menuBtn
        self.navigationItem.leftBarButtonItem = nil
        self.editMode = .view
        self.CustomCollectionView.reloadSections([0])
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
            self.navigationItem.rightBarButtonItem = self.cancleBtn
            self.navigationItem.leftBarButtonItem = self.deleteBtn
            self.editMode = .select
            self.selectDelegate?.setSelectMode()
//            UICollectionView.performWithoutAnimation {
                self.CustomCollectionView.reloadSections([0])
                print("1")
//            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in }
        actionSheet.addAction(first)
        actionSheet.addAction(second)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
}

extension CustomViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (UIDevice.current.orientation.isLandscape) {
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
    
    @IBOutlet weak var checkMark: UIImageView!
    @IBOutlet weak var editView: UIView!
    @IBAction func tapCardBtn(_ sender: Any) {
        moveToListMethod?()
    }
    @IBAction func tapQuizBtn(_ sender: Any) {
        moveToQuizMethod?()
    }
    
    var moveToListMethod: (() -> Void)?
    var moveToQuizMethod: (() -> Void)?
    var selecteDelegate: SelectModeDelegate? = nil
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                checkMark.image = UIImage(systemName: "checkmark.circle")
            } else {
                checkMark.image = UIImage(systemName: "circle")
            }
        }
    }
    
    func update(info: QuestionFolder2) {
        cardBtn.setTitle("\(info.folderName)", for: .normal)
        cardBtn.titleLabel?.font = .systemFont(ofSize: 30)

        cardBtn.backgroundColor = UIColor.white
        cardBtn.layer.cornerRadius = 5
//        cardBtn.layer.shadowOffset = CGSize(width: 0.5, height: 0.1)
        cardBtn.layer.shadowOpacity = 0.3
        cardBtn.layer.shadowRadius = 20
        countofQuestion.text = "\(info.questionList.count)개의 질문"
        
        checkMark.image = UIImage(systemName: "circle")
        checkMark.tintColor = .gray
        
        editView.layer.opacity = 0.1
    }
}
