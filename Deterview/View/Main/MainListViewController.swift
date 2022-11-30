//
//  MainListViewController.swift
//  Deterview
//
//  Created by 조석진 on 2022/12/01.
//

import UIKit

class MainListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let viewModel = TableViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.contOfcardList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as?
        TableCell else {
            return UITableViewCell()
        }
        let cellInfo = viewModel.cellInfo(at: indexPath.item)
        cell.update(info: cellInfo)

        return cell
    }
}


class TableCell: UITableViewCell {
    @IBOutlet weak var questionList: UILabel!
    
    func update(info: ListCellInfo) {
        questionList.text = info.question
    }
}

struct ListCellInfo {
    let question: String
    init(question: String) {
        self.question = question
    }
}

class TableViewModel{
    let listCellInfoList: [ListCellInfo] = [
        ListCellInfo(question: "가나다라마바사"),
        ListCellInfo(question: "아자차카타파하"),
        ListCellInfo(question: "가나다라마바사"),
        ListCellInfo(question: "아자차카타파하"),
        ListCellInfo(question: "가나다라마바사"),
        ListCellInfo(question: "아자차카타파하")
    ]
    
    var contOfcardList: Int {
        return listCellInfoList.count
    }
    
    func cellInfo(at index: Int) -> ListCellInfo {
        return listCellInfoList[index]
    }
}


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


