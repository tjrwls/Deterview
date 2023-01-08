//
//  CustomListViewController.swift
//  Deterview
//
//  Created by MIJU on 2022/12/12.
//

import UIKit

class CustomListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var questionStore: QuestionFolderStore? = nil
    var questionFolder: QuestionFolder? = nil
    
    lazy var menuBtn: UIBarButtonItem = {
        UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .done, target: self, action: #selector(tapMenuBtn))
    }()
    @IBOutlet weak var customListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = questionFolder?.folderName
        customListView.delegate = self
        customListView.dataSource = self
        
        menuBtn.tintColor = .black
        self.navigationItem.rightBarButtonItem = self.menuBtn
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionFolder?.questionList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: "delete") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            self.questionStore?.deleteQuestion(self.questionFolder?.questionList[indexPath.row].id ?? "")
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        delete.backgroundColor = .red
        let swipeAction = UISwipeActionsConfiguration(actions: [delete])
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
        guard let vc = self.storyboard?.instantiateViewController(identifier: "CustomDetailViewController") as? CustomDetailViewController else { return }
        vc.question = self.questionFolder?.questionList[indexPath.item]
        vc.questionStore = questionStore
        self.navigationController?.pushViewController(vc, animated: true)
        customListView.deselectRow(at: indexPath, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//           if editingStyle == .delete {
////               questionFolder?.questionList.remove(at: indexPath.row)
////               questionStore?.readQuestionFolder()
//               questionStore?.deleteQuestion(questionFolder?.questionList[indexPath.row].id ?? "")
//               tableView.deleteRows(at: [indexPath], with: .fade)
//           }
//       }
    
    func showActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let first = UIAlertAction(title: "폴더 추가하기", style: .default) { action in
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddingFolderViewController") as? AddingFolderViewController else { return }
            vc.modalPresentationStyle = .formSheet
            vc.customListViewController = self
            vc.questionStore = self.questionStore
            vc.folderId = self.questionFolder?.id ?? ""
            self.present(vc,animated: true)
        }
        let second = UIAlertAction(title: "편집하기", style: .default) { action in
//            self.navigationItem.rightBarButtonItem = self.cancelBtn
//            self.navigationItem.leftBarButtonItem = self.deleteBtn
//            self.editMode = .select
//            UIView.performWithoutAnimation {
//                self.customCollectionView.reloadSections([0])
//            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in }
        actionSheet.addAction(first)
        actionSheet.addAction(second)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }

    
    @objc func tapMenuBtn() {
        showActionSheet()
    }
    
}


class CustomTableCell: UITableViewCell {
    @IBOutlet weak var question: UILabel!
    
    
    
//    func update(info: ListCellInfo) {
//        questionList.text = info.question
//    }
}
