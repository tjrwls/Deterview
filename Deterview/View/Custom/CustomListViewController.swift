//
//  CustomListViewController.swift
//  Deterview
//
//  Created by MIJU on 2022/12/12.
//

import UIKit

final class CustomListViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var customListView: UITableView!
    
    var questionStore: QuestionFolderStore?
    var questionFolder: QuestionFolder?
//    lazy var menuBtn: UIBarButtonItem = {
//        UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .done, target: self, action: #selector(tapMenuBtn))
//    }()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        questionFolder = questionStore?.customQuestionFolders.filter {
            $0.id == questionFolder?.id
        }.first ?? QuestionFolder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        customListView.reloadData()
    }
    // MARK: - Methods
    private func showActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let first = UIAlertAction(title: "질문 추가하기", style: .default) { _ in
            guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "AddingFolderViewController") as? AddingFolderViewController else { return }
            
            viewController.modalPresentationStyle = .formSheet
            viewController.customListViewController = self
            viewController.questionStore = self.questionStore
            viewController.folderId = self.questionFolder?.id ?? ""
            
            self.present(viewController, animated: true)
        }
        let second = UIAlertAction(title: "질문 불러오기", style: .default) { _ in
            guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SelectedQuestionFolderViewController") as? SelectedQuestionFolderViewController else { return }
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.navigationBar.barTintColor = .white
            viewController.questionStore = self.questionStore
            viewController.addToFolderId = self.questionFolder?.id ?? ""
            navigationController.modalPresentationStyle = .fullScreen
            
            self.present(navigationController, animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { _ in }
        
        actionSheet.addAction(first)
        actionSheet.addAction(second)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }

    private func configureUI() {
        configureNavigation()
        configureCustomListView()
    }
    
    private func configureNavigation() {
        self.navigationItem.title = questionFolder?.folderName
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .done, target: self, action: #selector(tapMenuBtn))
        self.navigationItem.rightBarButtonItem?.tintColor = .black
    }
    
    private func configureCustomListView() {
        customListView.delegate = self
        customListView.dataSource = self
    }
    
    @objc func tapMenuBtn() {
        showActionSheet()
    }
}

// MARK: - TableView DataSource
extension CustomListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionFolder?.questionList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "delete") { (_, _, _: @escaping (Bool) -> Void) in
            self.questionStore?.deleteQuestion(self.questionFolder?.questionList[indexPath.row].id ?? "")
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        let swipeAction = UISwipeActionsConfiguration(actions: [delete])
        delete.backgroundColor = .red
        swipeAction.performsFirstActionWithFullSwipe = false
        
        return swipeAction
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableCell", for: indexPath) as?
        CustomTableCell else {
            return UITableViewCell()
        }
        cell.question.text = questionFolder?.questionList[indexPath.row].question
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "CustomDetailViewController") as? CustomDetailViewController else { return }
        
        viewController.questionStore = questionStore
        viewController.question = self.questionFolder?.questionList[indexPath.item]
        
        self.navigationController?.pushViewController(viewController, animated: true)
        customListView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - TableView Delegate
extension CustomListViewController: UITableViewDelegate {
    
}

// MARK: - CustomTable Cell
final class CustomTableCell: UITableViewCell {
    @IBOutlet weak var question: UILabel!
}
