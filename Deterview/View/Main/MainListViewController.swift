//
//  MainListViewController.swift
//  Deterview
//
//  Created by 조석진 on 2022/12/01.
//

import UIKit

class MainListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var questionList: [Question] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as?
        TableCell else {
            return UITableViewCell()
        }
        
        cell.question.text = questionList[indexPath.item].question
        return cell
    }
}


class TableCell: UITableViewCell {
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


 
