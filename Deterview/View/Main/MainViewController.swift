//
//  MainViewController.swift
//  Deterview
//
//  Created by 조석진 on 2022/11/30.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource {
    let viewModel = MainViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    // 섹션에 표시 할 셀 갯수를 묻는 메서드
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.contOfcardList
    }
    
    // 콜렉션 뷰의 특정 인덱스에서 표시할 셀을 요청하는 메서드
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as?
                CardListCell else {
            return UICollectionViewCell()
        }
        let cellInfo = viewModel.cellInfo(at: indexPath.item)
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
    
    func update(info: CellInfo) {
        cardBtn.setTitle("\(info.name)", for: .normal)
        cardBtn.titleLabel?.font = .systemFont(ofSize: 35)
        cardBtn.layer.borderColor = UIColor.black.cgColor
        cardBtn.layer.borderWidth = 1
        cardBtn.layer.cornerRadius = 10
        countofQuestion.text = "\(info.countOfWord)개의 질문"
    }
}

struct CellInfo {
    let name: String
    let countOfWord: Int
    
    init(name: String, countOfWord: Int) {
        self.name = name
        self.countOfWord = countOfWord
    }
}

class MainViewModel{
    let cellInfoList: [CellInfo] = [
        CellInfo(name: "CS", countOfWord: 24),
        CellInfo(name: "iOS", countOfWord: 25),
        CellInfo(name: "aOS", countOfWord: 26),
        CellInfo(name: "Front-End", countOfWord: 27),
        CellInfo(name: "Back-End", countOfWord: 28)
    ]
    
    var contOfcardList: Int {
        return cellInfoList.count
    }
    
    func cellInfo(at index: Int) -> CellInfo {
        return cellInfoList[index]
    }
}
