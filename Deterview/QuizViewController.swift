//
//  QuizViewController.swift
//  Deterview
//
//  Created by MIJU on 2022/12/05.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var answerText: UILabel!
    @IBOutlet weak var nextQuizBtn: UIButton!
    
    @IBOutlet weak var placeholderText: UILabel!
    @IBOutlet weak var answerView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionText.text = "dddddd"
        answerText.text = "dkdkdkkdk"
        answerText.layer.isHidden = true
        placeholderText.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapNextBtn(_ sender: Any) {
        questionText.text = "ㅎㅎㅎㅎㅎㅎㅎㅎㅎㅎ"
        answerText.text = "아아아아아아아아아아아아아아"
    }
    
    @IBAction func tapAnswerView(_ sender: UIGestureRecognizer) {
        answerText.isHidden.toggle()
        placeholderText.isHidden.toggle()
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
