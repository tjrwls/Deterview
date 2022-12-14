//
//  CustomListViewController.swift
//  Deterview
//
//  Created by MIJU on 2022/12/12.
//

import UIKit

class CustomListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var questionTableView: UITableView!
    var folderName: String = ""
    var questionList: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = folderName
        questionTableView.delegate = self
        questionTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableCell", for: indexPath) as?
        CustomTableCell else {
            return UITableViewCell()
        }
        
        cell.question.text = questionList[indexPath.item].question
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "MainDetailViewController") as? MainDetailViewController else { return }
        vc.question = self.questionList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        questionTableView.deselectRow(at: indexPath, animated: true)
    }
}


class CustomTableCell: UITableViewCell {
    @IBOutlet weak var question: UILabel!
    
    
    
//    func update(info: ListCellInfo) {
//        questionList.text = info.question
//    }
}
