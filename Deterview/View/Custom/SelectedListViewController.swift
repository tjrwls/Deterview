//
//  SelectedListViewController.swift
//  Deterview
//
//  Created by 조석진 on 2023/01/10.
//

import UIKit

final class SelectedListViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet weak var selectedListView: UITableView!
    
    private var selectedIndex: [Int: Bool] = [:]
    var questionStore: QuestionFolderStore?
    var questionFolder: QuestionFolder?
    var addToFolderId: String?
//    lazy var completeBtn: UIBarButtonItem = {
//        UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(tapSaveBtn))
//    }()

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        questionFolder = questionStore?.mainQuestionFolders.filter {
            $0.id == questionFolder?.id
        }.first ?? QuestionFolder()
    }
    
    // MARK: - Methods
    private func configureUI() {
        configureSelectedListView()
        configureNavigation()
    }
    
    private func configureSelectedListView() {
        selectedListView.delegate = self
        selectedListView.dataSource = self
        selectedListView.allowsMultipleSelection = false
    }
    
    private func configureNavigation() {
        self.navigationItem.title = questionFolder?.folderName
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(tapSaveBtn))
        self.navigationItem.rightBarButtonItem?.isEnabled = false
    }
    
    @objc func tapSaveBtn() {
        for (key, value) in selectedIndex.sorted(by: { $0.key < $1.key}) where value {
                let question = questionFolder?.questionList[key]
            questionStore?.loadQuestion(folderId: addToFolderId ?? "", question: question?.question ?? "", answer: question?.answer ?? "")
        }
        self.dismiss(animated: true)
    }
}

// MARK: - TableView DataSource
extension SelectedListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionFolder?.questionList.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectedTableCell", for: indexPath) as? SelectedTableCell else {
            return UITableViewCell()
        }
        cell.question.text = questionFolder?.questionList[indexPath.row].question
        cell.checkMark.image = UIImage(systemName: "circle")
        cell.checkMark.tintColor = UIColor(named: "mainColor")
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndex[indexPath.row] == true {
            selectedIndex[indexPath.row] = false
        } else {
            selectedIndex[indexPath.row] = true
        }
        let cell = selectedListView.cellForRow(at: indexPath) as! SelectedTableCell
        cell.isCheked.toggle()
        
        self.navigationItem.rightBarButtonItem?.isEnabled = selectedIndex.filter { $0.value == true }.count > 0
    }
}

// MARK: - TableView Delegate
extension SelectedListViewController: UITableViewDelegate {
    
}

// MARK: - SelectedTable Cell
final class SelectedTableCell: UITableViewCell {
    // MARK: - Properties
    @IBOutlet weak var checkMark: UIImageView!
    @IBOutlet weak var question: UILabel!
    
    var isCheked: Bool = false {
        didSet {
            if isCheked {
                checkMark.image = UIImage(systemName: "checkmark.circle")
            } else {
                checkMark.image = UIImage(systemName: "circle")
            }
        }
    }
}
