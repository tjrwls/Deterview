//
//  MainViewController.swift
//  Deterview
//
//  Created by 조석진 on 2022/11/30.
//

import UIKit


class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var templateData: [QuestionFolder] = TemplateData().templateData
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.systemGray6
        
    }
    // 섹션에 표시 할 셀 갯수를 묻는 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return templateData.count
    }
    // 콜렉션 뷰의 특정 인덱스에서 표시할 셀을 요청하는 메서드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardListCell", for: indexPath) as?
                CardListCell else {
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 5
        
        cell.moveToListMethod = {
            let index = indexPath.row
            guard let vc = self.storyboard?.instantiateViewController(identifier: "MainListViewController") as? MainListViewController else { return }
            
            vc.questionList = self.templateData[index].questionList
            vc.folderName = self.templateData[index].folderName
            self.navigationController?.pushViewController(vc, animated: true)
        }
        cell.moveToQuizMethod = {
            let index = indexPath.row
            guard let vc = self.storyboard?.instantiateViewController(identifier: "QuizViewController") as? QuizViewController else { return }
            
            vc.questionList = self.templateData[index].questionList
            self.navigationController?.pushViewController(vc, animated: true)
        }
       
        let cellInfo = templateData[indexPath.item]
        cell.update(info: cellInfo)
        return cell
    }
    //셀이 선택되었을 때
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

class CardListCell: UICollectionViewCell {
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
        
//        cardBtn.layer.shadowOffset = CGSize(width: 0.5, height: 0.1)
        cardBtn.layer.shadowOpacity = 0.3
        cardBtn.layer.shadowRadius = 20
        countofQuestion.text = "\(info.questionList.count)개의 질문"
    }
}
