//
//  SelectedListViewController.swift
//  Deterview
//
//  Created by 조석진 on 2023/01/10.
//

import UIKit

class SelectedListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var questionStore: QuestionFolderStore? = nil
    var questionFolder: QuestionFolder? = nil
    var addToFolderId: String = ""
    var selectedIndex: [Int:Bool] = [:]
    lazy var completeBtn: UIBarButtonItem = {
        UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(tapSaveBtn))
    }()

    @IBOutlet weak var selectedListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = questionFolder?.folderName
        selectedListView.delegate = self
        selectedListView.dataSource = self
        selectedListView.allowsMultipleSelection = false
        
        questionFolder = questionStore?.mainQuestionFolders.filter {
            $0.id == questionFolder?.id
        }.first ?? QuestionFolder()
        
        completeBtn.isEnabled = false
        self.navigationItem.rightBarButtonItem = self.completeBtn
        // Do any additional setup after loading the view.
    }
    
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
    
    //셀선택시
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedIndex[indexPath.row] == true {
            selectedIndex[indexPath.row] = false
        } else {
            selectedIndex[indexPath.row] = true
        }
        let cell = selectedListView.cellForRow(at: indexPath) as! SelectedTableCell
        cell.isCheked.toggle()
        
        completeBtn.isEnabled = selectedIndex.filter{ $0.value == true}.count > 0
    }
    
    
    @objc func tapSaveBtn() {
        for (key,value) in selectedIndex.sorted(by: { $0.key < $1.key}) {
            if value {
                let question = questionFolder?.questionList[key]
                questionStore?.loadQuestion(folderId: addToFolderId, question: question?.question ?? "", answer: question?.answer ?? "")
            }
        }
        self.dismiss(animated: true)
    }
}

class SelectedTableCell: UITableViewCell {
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
