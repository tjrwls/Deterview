//
//  MainDetailViewController.swift
//  Deterview
//
//  Created by MIJU on 2022/12/03.
//

import UIKit

class MainDetailViewController: UIViewController {
    @IBOutlet weak var answerText: UILabel!
    @IBOutlet weak var questionText: UILabel!
    var isShowingAnswerTextField: Bool = false
    var isShowingAnswerText: Bool = false
    var question: Question? = nil
    
    @IBOutlet weak var answerTextField: UITextView!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        answerText.numberOfLines = 0
        answerText.sizeToFit()
        answerText.text = question?.answer
        questionText.text = question?.question
        answerTextField.layer.borderWidth = 1
        answerTextField.layer.isHidden = true
        editBtn.layer.isHidden = false
        saveBtn.layer.isHidden = true
    }
    
    @IBAction func tapEditBtn(_ sender: Any) {
        answerText.layer.isHidden.toggle()
        editBtn.layer.isHidden.toggle()
        saveBtn.layer.isHidden.toggle()
        answerTextField.text = answerText.text
        answerTextField.layer.isHidden.toggle()
    }
    
    @IBAction func tapSaveBtn(_ sender: Any) {
        answerText.layer.isHidden.toggle()
        editBtn.layer.isHidden.toggle()
        saveBtn.layer.isHidden.toggle()
        answerTextField.layer.isHidden.toggle()
        answerText.text = answerTextField.text
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
