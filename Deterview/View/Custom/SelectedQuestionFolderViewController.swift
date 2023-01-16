//
//  SelectedQuestionFolderViewController.swift
//  Deterview
//
//  Created by 조석진 on 2023/01/09.
//

import UIKit

class SelectedQuestionFolderViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var questionStore: QuestionFolderStore? = nil
    var addToFolderId: String = ""
    @IBOutlet weak var collectionView: UICollectionView!

    lazy var cancelBtn: UIBarButtonItem = {
        UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(tapCancelBtn))
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemGray6
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.systemGray6
        
        self.title = "폴더 선택"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.leftBarButtonItem = self.cancelBtn
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        QuestionFolderStore().updateQuestionFolder()
//        self.collectionView.reloadData()
//    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    // 섹션에 표시 할 셀 갯수를 묻는 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionStore?.mainQuestionFolders.count ?? 0
    }
    // 콜렉션 뷰의 특정 인덱스에서 표시할 셀을 요청하는 메서드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeletedCardListCell", for: indexPath) as?
                SeletedCardListCell else {
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 5
        
        cell.moveToListMethod = {
            let index = indexPath.row
            guard let vc = self.storyboard?.instantiateViewController(identifier: "SelectedListViewController") as? SelectedListViewController else { return }
            
            vc.questionStore = self.questionStore
            vc.questionFolder = self.questionStore?.mainQuestionFolders[index]
            vc.addToFolderId = self.addToFolderId
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        let cellInfo = questionStore?.mainQuestionFolders[indexPath.item] ?? QuestionFolder()
        cell.update(info: cellInfo)
        return cell
    }
    //셀이 선택되었을 때
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.invalidateLayout() // 현재 layout을 무효화하고 layout 업데이트를 작동
        }
    }
    
    @objc func tapCancelBtn() {
        self.dismiss(animated: true)
    }
    
}

extension SelectedQuestionFolderViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (UIDevice.current.orientation.isLandscape) {
            return CGSize(width: collectionView.bounds.width / 2 - 20, height: 100)
        } else {
            return CGSize(width: collectionView.bounds.width - 10, height: 100)
        }
    }
}

class SeletedCardListCell: UICollectionViewCell {
    @IBOutlet weak var cardBtn: UIButton!
    @IBOutlet weak var countofQuestion: UILabel!
    
    @IBAction func tabCardBtn(_ sender: Any) {
        moveToListMethod?()
    }
    
    var moveToListMethod: (() -> Void)?

    func update(info: QuestionFolder) {
        cardBtn.setTitle("\(info.folderName)", for: .normal)
        cardBtn.titleLabel?.font = .systemFont(ofSize: 30
        )

        cardBtn.backgroundColor = UIColor.white
        cardBtn.layer.cornerRadius = 5
        cardBtn.layer.shadowOpacity = 0.3
        cardBtn.layer.shadowRadius = 20
        countofQuestion.text = "\(info.questionList.count)개의 질문"
    }
}
