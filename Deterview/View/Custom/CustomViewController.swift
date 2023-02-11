//
//  CustomViewController.swift
//  Deterview
//
//  Created by MIJU on 2022/12/12.
//

import UIKit

final class CustomViewController: UIViewController {
    // MARK: - Properties
    enum Mode {
        case view
        case select
    }
    
    @IBOutlet weak var navigationCoverView: UIView!
    @IBOutlet weak var customCollectionView: UICollectionView!
    
    private let questionStore: QuestionFolderStore = QuestionFolderStore()
    private var dictionarySelectedIndexPath: [IndexPath: Bool] = [:]
    private var editMode: Mode = .view {
        didSet {
            switch editMode {
            case .view:
                dictionarySelectedIndexPath.removeAll()
                self.customCollectionView.allowsMultipleSelection = false
            case .select:
                self.customCollectionView.allowsMultipleSelection = true
            }
        }
    }
    
    lazy var menuBtn: UIBarButtonItem = {
        UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .done, target: self, action: #selector(tapMenuBtn))
    }()
    
    lazy var cancelBtn: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(tapCancelBtn))
    }()
    
    lazy var deleteBtn: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(tapDeleteBtn))
    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        questionStore.readQuestionFolder()
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

    // MARK: - Methods
    private func showActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let first = UIAlertAction(title: "폴더 추가하기", style: .default) { _ in
            guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "AddingFolderViewController") as? AddingFolderViewController else { return }
            
            viewController.modalPresentationStyle = .formSheet
            viewController.customViewController = self
            viewController.questionStore = self.questionStore
            
            self.present(viewController, animated: true)
        }
        let second = UIAlertAction(title: "편집하기", style: .default) { _ in
            self.navigationItem.rightBarButtonItem = self.cancelBtn
            self.navigationItem.leftBarButtonItem = self.deleteBtn
            self.editMode = .select
            
            UIView.performWithoutAnimation {
                self.customCollectionView.reloadSections([0])
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        actionSheet.addAction(first)
        actionSheet.addAction(second)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    private func configureUI() {
        self.view.backgroundColor = UIColor.systemGray6
        self.navigationItem.rightBarButtonItem = self.menuBtn
        menuBtn.tintColor = .black
        navigationCoverView.backgroundColor = UIColor.systemGray6
        configureCustomCollectionView()
    }
    
    private func configureCustomCollectionView() {
        customCollectionView.delegate = self
        customCollectionView.dataSource = self
        customCollectionView.backgroundColor = UIColor.systemGray6
        customCollectionView.allowsMultipleSelection = false
    }
    
    @objc func tapMenuBtn() {
        if UIDevice.current.userInterfaceIdiom != .pad {
            showActionSheet()
        }
    }
    
    @objc func tapCancelBtn() {
        self.navigationItem.rightBarButtonItem = self.menuBtn
        self.navigationItem.leftBarButtonItem = nil
        self.editMode = .view
        
        UIView.performWithoutAnimation {
            self.customCollectionView.reloadSections([0])
        }
    }
    
    @objc func tapDeleteBtn() {
        let alert = UIAlertController(title: "삭제", message: "폴더를 삭제하시겠습니까?", preferredStyle: .alert)
        let close = UIAlertAction(title: "취소", style: .default) {_ in
            self.navigationController?.popViewController(animated: true)
        }
        let retry = UIAlertAction(title: "삭제", style: .destructive) {_ in
            for (key, value) in self.dictionarySelectedIndexPath where value {
                    let id: String = self.questionStore.customQuestionFolders[key.row].id
                    self.questionStore.deleteQuestionFolder(id)
            }
            self.dictionarySelectedIndexPath.removeAll()
            self.questionStore.readQuestionFolder()
            self.customCollectionView.reloadSections([0])
            self.editMode = .view
            self.navigationItem.rightBarButtonItem = self.menuBtn
            self.navigationItem.leftBarButtonItem = nil
        }
        
        alert.addAction(close)
        alert.addAction(retry)
        
        self.present(alert, animated: false)
    }
}

// MARK: - CollectionView DelegateFlowLayout
extension CustomViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if Int(view.window?.windowScene?.screen.bounds.width ?? 0) > Int(view.window?.windowScene?.screen.bounds.height ?? 0) {
            return CGSize(width: collectionView.bounds.width / 2 - 20, height: 100)
        } else {
            return CGSize(width: collectionView.bounds.width - 10, height: 100)
        }
    }
}

// MARK: - CollectionView DataSource
extension CustomViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionStore.customQuestionFolders.count
    }
    // 콜렉션 뷰의 특정 인덱스에서 표시할 셀을 요청하는 메서드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCardListCell", for: indexPath) as?
                CustomCardListCell else {
            return UICollectionViewCell()
        }
        
        cell.moveToListMethod = {
            let index = indexPath.row
            guard let viewController = self.storyboard?.instantiateViewController(identifier: "CustomListViewController") as? CustomListViewController else { return }
            
            viewController.questionStore = self.questionStore
            viewController.questionFolder = self.questionStore.customQuestionFolders[index]
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        cell.moveToQuizMethod = {
            let index = indexPath.row
            
            if self.questionStore.customQuestionFolders[index].questionList.isEmpty {
                let alert = UIAlertController(title: "문제풀기", message: "풀 수 있는 문제가 없습니다.\n문제를 추가해주세요.", preferredStyle: .alert)
                let retry = UIAlertAction(title: "확인", style: .default)
                
                alert.addAction(retry)
                
                self.present(alert, animated: false)
            } else {
                guard let viewController = self.storyboard?.instantiateViewController(identifier: "QuizViewController") as? QuizViewController else { return }
                
                viewController.questionList = self.questionStore.customQuestionFolders[index].questionList
                viewController.folderName = self.questionStore.customQuestionFolders[index].folderName
                
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
        
        cell.editFolderNameMethod = {
            let index = indexPath.row
            guard let viewController = self.storyboard?.instantiateViewController(identifier: "EditingFolderNameViewController") as? EditingFolderNameViewController else { return }
            
            viewController.questionFolder = self.questionStore.customQuestionFolders[index]
            viewController.questionStore = self.questionStore
            viewController.viewController = self
            
            self.present(viewController, animated: true)
        }
        
        let cellInfo = questionStore.customQuestionFolders[indexPath.row]
        cell.configureUI(info: cellInfo)
        
        switch editMode {
        case .view:
            cell.checkMark.isHidden = true
            cell.editView.isHidden = true
            cell.editFolderNameBtn.isHidden = true
        case .select:
            cell.editView.isHidden = false
            cell.checkMark.isHidden = false
            cell.editFolderNameBtn.isHidden = false
        }
        return cell
    }
    
    // 셀이 선택되었을 때
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch editMode {
        case .view:
            break
        case .select:
            dictionarySelectedIndexPath[indexPath] = true
        }
    }
}

// MARK: - CollectionView Delegate
extension CustomViewController: UICollectionViewDelegate {
    
}

// MARK: - CustomCardList Cell
final class CustomCardListCell: UICollectionViewCell {
    // MARK: - Properties
    @IBOutlet weak var folderBtn: UIButton!
    @IBOutlet weak var quizBtn: UIButton!
    @IBOutlet weak var countOfQuestion: UILabel!
    @IBOutlet weak var folderNameText: UILabel!
    @IBOutlet weak var checkMark: UIImageView!
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var editFolderNameImage: UIImageView!
    @IBOutlet weak var editFolderNameBtn: UIButton!
    
    private var questionCount: Int = 0
    var moveToListMethod: (() -> Void)?
    var moveToQuizMethod: (() -> Void)?
    var editFolderNameMethod: (() -> Void)?
    
    // MARK: - Methods
    override var isSelected: Bool {
        didSet {
            if isSelected {
                checkMark.image = UIImage(systemName: "checkmark.circle")
            } else {
                checkMark.image = UIImage(systemName: "circle")
            }
        }
    }
    
    @IBAction func tapCardBtn(_ sender: Any) {
        moveToListMethod?()
    }
    
    @IBAction func tapQuizBtn(_ sender: Any) {
        moveToQuizMethod?()
    }
    
    @IBAction func tapEditFolderNameBtn(_ sender: Any) {
        editFolderNameMethod?()
    }
    
    private func configureQuizBtn() {
        quizBtn.backgroundColor = UIColor(.mainColor)
        quizBtn.setTitleColor(.white, for: .normal)
        quizBtn.layer.cornerRadius = 5
    }
    
    private func configureCardBtn() {
        folderBtn.backgroundColor = UIColor.white
        folderBtn.layer.cornerRadius = 5
        folderBtn.layer.shadowOpacity = 0.3
        folderBtn.layer.shadowRadius = 20
    }
    
    private func configureFolderNameText(info: QuestionFolder) {
        folderNameText.text = info.folderName
        folderNameText.font = .systemFont(ofSize: 30)
    }
    
    private func configureEditFolderNameBtn() {
        editFolderNameBtn.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        editFolderNameBtn.tintColor = UIColor(named: "AccentColor")
        editFolderNameBtn.imageView?.contentMode = .scaleAspectFit
    }
    
    private func configureCheckMark() {
        checkMark.image = UIImage(systemName: "circle")
        checkMark.tintColor = .gray
    }
    
    func configureUI(info: QuestionFolder) {
        self.layer.cornerRadius = 5
        editView.layer.opacity = 0.1
        questionCount = info.questionList.count
        countOfQuestion.text = "\(info.questionList.count)개의 질문"
        configureQuizBtn()
        configureCardBtn()
        configureFolderNameText(info: info)
        configureEditFolderNameBtn()
        configureCheckMark()
    }
}
