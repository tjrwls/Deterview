//
//  MainListViewController.swift
//  Deterview
//
//  Created by 조석진 on 2022/12/01.
//

import UIKit

class MainListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var questionTableView: UITableView!
    var questionStore: QuestionFolderStore? = nil
    var questionFolder: QuestionFolder? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = questionFolder?.folderName
        questionTableView.delegate = self
        questionTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionFolder?.questionList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableCell", for: indexPath) as?
        MainTableCell else {
            return UITableViewCell()
        }
        
        cell.question.text = questionFolder?.questionList[indexPath.item].question
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = self.storyboard?.instantiateViewController(identifier: "MainDetailViewController") as? MainDetailViewController else { return }
        vc.questionStore = questionStore
        vc.question = self.questionFolder?.questionList[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        questionTableView.deselectRow(at: indexPath, animated: true)
    }
}


class MainTableCell: UITableViewCell {
    @IBOutlet weak var question: UILabel!
    
    
    
//    func update(info: ListCellInfo) {
//        questionList.text = info.question
//    }
}



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


 
