//
//  SelectedQuestionFolderViewController.swift
//  Deterview
//
//  Created by 조석진 on 2023/01/09.
//

import UIKit

final class SelectedQuestionFolderViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var collectionView: UICollectionView!
    
    var addToFolderId: String?
    var questionStore: QuestionFolderStore?
//    var cancelBtn: UIBarButtonItem =
//    UIBarButtonItem(barButtonSystemItem: .cancel, target: SelectedQuestionFolderViewController.self, action: #selector(tapCancelBtn))
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "폴더 선택"
        configureUI()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.invalidateLayout() // 현재 layout을 무효화하고 layout 업데이트를 작동
        }
    }
    
    // MARK: - Methods
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    private func configureUI() {
        configureNavigation()
        configureCollection()
    }
    
    private func configureNavigation() {
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(tapCancelBtn))
    }
    
    private func configureCollection() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.systemGray6
    }
    
    @objc func tapCancelBtn() {
        self.dismiss(animated: true)
    }
    
}

// MARK: - CollectionViewDelegateFlowLayout
extension SelectedQuestionFolderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.orientation.isLandscape {
            return CGSize(width: collectionView.bounds.width / 2 - 20, height: 100)
        } else {
            return CGSize(width: collectionView.bounds.width - 10, height: 100)
        }
    }
}
// MARK: - CollectionView DataSource
extension SelectedQuestionFolderViewController: UICollectionViewDataSource {
    /// 섹션에 표시 할 셀 갯수를 묻는 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionStore?.mainQuestionFolders.count ?? 0
    }
    
    /// 콜렉션 뷰의 특정 인덱스에서 표시할 셀을 요청하는 메서드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeletedCardListCell", for: indexPath) as?
                SeletedCardListCell else {
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 5
        
        cell.moveToListMethod = {
            let index = indexPath.row
            guard let viewController = self.storyboard?.instantiateViewController(identifier: "SelectedListViewController") as? SelectedListViewController else { return }
            
            viewController.questionStore = self.questionStore
            viewController.questionFolder = self.questionStore?.mainQuestionFolders[index]
            viewController.addToFolderId = self.addToFolderId ?? ""
            self.navigationController?.pushViewController(viewController, animated: true)
            
        }
        
        let cellInfo = questionStore?.mainQuestionFolders[indexPath.item] ?? QuestionFolder()
        cell.update(info: cellInfo)
        
        return cell
    }
}

// MARK: - CollectionView Delegate
extension SelectedQuestionFolderViewController: UICollectionViewDelegate {
    
}

// MARK: - SelectedCardList Cell
final class SeletedCardListCell: UICollectionViewCell {
    // MARK: - Properties
    @IBOutlet weak var cardBtn: UIButton!
    @IBOutlet weak var countofQuestion: UILabel!
    
    @IBAction func tabCardBtn(_ sender: Any) {
        moveToListMethod?()
    }
    
    var moveToListMethod: (() -> Void)?

    // MARK: - Methods
    func update(info: QuestionFolder) {
        cardBtn.setTitle("\(info.folderName)", for: .normal)
        cardBtn.titleLabel?.font = .systemFont(ofSize: 30)
        cardBtn.backgroundColor = UIColor.white
        cardBtn.layer.cornerRadius = 5
        cardBtn.layer.shadowOpacity = 0.3
        cardBtn.layer.shadowRadius = 20
        countofQuestion.text = "\(info.questionList.count)개의 질문"
    }
}
