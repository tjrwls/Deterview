//
//  MainListViewController.swift
//  Deterview
//
//  Created by 조석진 on 2022/12/01.
//

import UIKit

final class MainListViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var questionTableView: UITableView!
    
    var questionStore: QuestionFolderStore?
    var questionFolder: QuestionFolder?
    
    // MARK: - Lifecycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Methods
    private func configureUI() {
        configureQuestionTableView()
        self.navigationItem.title = questionFolder?.folderName
    }
    
    private func configureQuestionTableView() {
        questionTableView.delegate = self
        questionTableView.dataSource = self
    }
}

// MARK: - TableView DataSource
extension MainListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionFolder?.questionList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableCell", for: indexPath) as? MainTableCell else {
            return UITableViewCell()
        }
        cell.question.text = questionFolder?.questionList[indexPath.item].question
        
        return cell
    }
}

// MARK: - TableView Delegate
extension MainListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "MainDetailViewController") as? MainDetailViewController else { return }
        
        viewController.questionStore = questionStore
        viewController.question = self.questionFolder?.questionList[indexPath.row]
        
        self.navigationController?.pushViewController(viewController, animated: true)
        questionTableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - MainTableCell
final class MainTableCell: UITableViewCell {
    @IBOutlet weak var question: UILabel!
}
