//
//  MainListViewController.swift
//  Deterview
//
//  Created by 조석진 on 2022/12/01.
//

import UIKit

final class MainListViewController: UIViewController {
    var questionStore: QuestionFolderStore?
    var questionFolder: QuestionFolder?
    
    @IBOutlet weak var questionTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionTableView.delegate = self
        questionTableView.dataSource = self
        
        self.navigationItem.title = questionFolder?.folderName
    }
}

extension MainListViewController: UITableViewDataSource {
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
}

extension MainListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "MainDetailViewController") as? MainDetailViewController else { return }
        
        viewController.questionStore = questionStore
        viewController.question = self.questionFolder?.questionList[indexPath.row]
        
        self.navigationController?.pushViewController(viewController, animated: true)
        questionTableView.deselectRow(at: indexPath, animated: true)
    }
}

final class MainTableCell: UITableViewCell {
    @IBOutlet weak var question: UILabel!
}
