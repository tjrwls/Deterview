//
//  MainViewController.swift
//  Deterview
//
//  Created by 조석진 on 2022/11/30.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var questionStore: QuestionFolderStore = QuestionFolderStore()
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.systemGray6
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.systemGray6
        questionStore.readQuestionFolder()
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    // 섹션에 표시 할 셀 갯수를 묻는 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionStore.mainQuestionFolders.count
    }
    // 콜렉션 뷰의 특정 인덱스에서 표시할 셀을 요청하는 메서드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCardListCell", for: indexPath) as?
                MainCardListCell else {
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 5
        
        cell.moveToListMethod = {
            let index = indexPath.row
            guard let vc = self.storyboard?.instantiateViewController(identifier: "MainListViewController") as? MainListViewController else { return }
            vc.questionStore = self.questionStore
            vc.questionFolder = self.questionStore.mainQuestionFolders[index]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        cell.moveToQuizMethod = {
            let index = indexPath.row
            guard let vc = self.storyboard?.instantiateViewController(identifier: "QuizViewController") as? QuizViewController else { return }
            
            vc.questionList = self.questionStore.mainQuestionFolders[index].questionList
            vc.folderName = self.questionStore.mainQuestionFolders[index].folderName
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let cellInfo = questionStore.mainQuestionFolders[indexPath.item]
        cell.update(info: cellInfo)
        return cell
    }
    //셀이 선택되었을 때
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.invalidateLayout()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        if let flowLayout = self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.invalidateLayout()
        }
    }

}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (Int(self.view.window?.windowScene?.screen.bounds.width ?? 0) > Int(view.window?.windowScene?.screen.bounds.height ?? 0)) {

            return CGSize(width: collectionView.bounds.width / 2 - 20, height: 100)
        } else {
            return CGSize(width: collectionView.bounds.width - 10, height: 100)
        }
    }
}

class MainCardListCell: UICollectionViewCell {
    @IBOutlet weak var cardBtn: UIButton!
    @IBOutlet weak var movequizBtn: UIButton!
    @IBOutlet weak var countofQuestion: UILabel!
    
    var moveToListMethod: (() -> Void)?
    var moveToQuizMethod: (() -> Void)?
    
    @IBAction func tapCardBtn(_ sender: Any) {
        moveToListMethod?()
    }
    @IBAction func tapQuizBtn(_ sender: Any) {
        moveToQuizMethod?()
    }
    
    func update(info: QuestionFolder) {
        cardBtn.setTitle("\(info.folderName)", for: .normal)
        cardBtn.titleLabel?.font = .systemFont(ofSize: 30
        )
        cardBtn.backgroundColor = UIColor.white
        cardBtn.layer.cornerRadius = 5
        cardBtn.layer.shadowOpacity = 0.3
        cardBtn.layer.shadowRadius = 20
        countofQuestion.text = "\(info.questionList.count)개의 질문"
        movequizBtn.backgroundColor = UIColor(named: "mainColor")
        movequizBtn.setTitleColor(.white, for: .normal)
        movequizBtn.layer.cornerRadius = 5
//        movequizBtn.tintColor = .white
//        movequizBtn.titleLabel?.size
    }
}
