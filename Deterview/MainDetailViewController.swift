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
        questionText.numberOfLines = 0
        questionText.text = question?.question
        questionText.font = .systemFont(ofSize: 24
        )
        
        answerText.numberOfLines = 0
        answerText.sizeToFit()
        answerText.text = question?.answer
        answerText.font = .systemFont(ofSize: 22, weight: .light)
        answerText.setLineSpacing(spacing: 5)
        
        answerTextField.layer.borderWidth = 1
        answerTextField.layer.borderColor = UIColor.gray.cgColor
        answerTextField.layer.isHidden = true
        answerTextField.font = .systemFont(ofSize: 22)
        answerTextField.setLineSpacing(spacing: 2)
        
        editBtn.layer.isHidden = false
        saveBtn.layer.isHidden = true
        
        
        self.navigationItem.title = "Question"
        navigationItem.largeTitleDisplayMode = .never
        
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
extension UILabel {
    func setLineSpacing(spacing: CGFloat) {
        guard let text = text else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
}

extension UITextView {
    func setLineSpacing(spacing: CGFloat) {
        guard let text = text else { return }

        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
}
