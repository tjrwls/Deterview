//
//  MainViewController.swift
//  Deterview
//
//  Created by 조석진 on 2022/11/30.
//

import UIKit
import RealmSwift

final class MainViewController: UIViewController, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navigationCoverView: UIView!
    
    private let questionStore: QuestionFolderStore = QuestionFolderStore()
    private let templateData: TemplateData = TemplateData()
    
    // MARK: - Lifecycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        questionStore.readQuestionFolder()
        if questionStore.mainQuestionFolders.isEmpty {
            templateData.createdTemplateData()
            questionStore.readQuestionFolder()
        }
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
    
    private func configureUI() {
        self.view.backgroundColor = UIColor.systemGray6
        navigationCoverView.backgroundColor = UIColor.systemGray6
        configureCollectionView()
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.systemGray6
    }
}
// MARK: CollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questionStore.mainQuestionFolders.count
    }
    // 콜렉션 뷰의 특정 인덱스에서 표시할 셀을 요청하는 메서드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCardListCell", for: indexPath) as?
                MainCardListCell else {
            return UICollectionViewCell()
        }
        
        cell.moveToListMethod = {
            guard let viewController = self.storyboard?.instantiateViewController(identifier: "MainListViewController") as? MainListViewController else { return }
            let index = indexPath.row
            
            viewController.questionStore = self.questionStore
            viewController.questionFolder = self.questionStore.mainQuestionFolders[index]
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        cell.moveToQuizMethod = {
            guard let viewController = self.storyboard?.instantiateViewController(identifier: "QuizViewController") as? QuizViewController else { return }
            let index = indexPath.row
            
            viewController.questionList = self.questionStore.mainQuestionFolders[index].questionList
            viewController.folderName = self.questionStore.mainQuestionFolders[index].folderName
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        let cellInfo = questionStore.mainQuestionFolders[indexPath.item]
        cell.configureUI(info: cellInfo)
        
        return cell
    }
}

// MARK: - CollectionView DelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if Int(self.view.window?.windowScene?.screen.bounds.width ?? 0) > Int(view.window?.windowScene?.screen.bounds.height ?? 0) {

            return CGSize(width: collectionView.bounds.width / 2 - 20, height: 100)
        } else {
            return CGSize(width: collectionView.bounds.width - 10, height: 100)
        }
    }
}

final class MainCardListCell: UICollectionViewCell {
    @IBOutlet weak var folderBtn: UIButton!
    @IBOutlet weak var quizBtn: UIButton!
    @IBOutlet weak var countOfQuestion: UILabel!
    
    var moveToListMethod: (() -> Void)?
    var moveToQuizMethod: (() -> Void)?
    
    @IBAction func tapCardBtn(_ sender: Any) {
        moveToListMethod?()
    }
    
    @IBAction func tapQuizBtn(_ sender: Any) {
        moveToQuizMethod?()
    }
    
    func configureUI(info: QuestionFolder) {
        self.layer.cornerRadius = 5
        countOfQuestion.text = "\(info.questionList.count)개의 질문"
        configureMovequiezBtn()
        configureCardBtn(info: info)
    }
    
    func configureCardBtn(info: QuestionFolder) {
        folderBtn.setTitle("\(info.folderName)", for: .normal)
        folderBtn.titleLabel?.font = .systemFont(ofSize: 30)
        folderBtn.backgroundColor = UIColor.white
        folderBtn.layer.cornerRadius = 5
        folderBtn.layer.shadowOpacity = 0.3
        folderBtn.layer.shadowRadius = 20
    }
    
    func configureMovequiezBtn() {
        quizBtn.backgroundColor = UIColor(named: "mainColor")
        quizBtn.setTitleColor(.white, for: .normal)
        quizBtn.layer.cornerRadius = 5
    }
}
