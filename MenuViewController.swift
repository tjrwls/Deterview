//
//  MenuViewController.swift
//  Deterview
//
//  Created by MIJU on 2022/12/12.
//

import UIKit

class MenuViewController: UIViewController {

    
    @IBOutlet weak var menuBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func configureTapMeButtonMenu() {
        menuBtn.menu = UIMenu(title: "Your options...", children: [UIAction(title: "Option 1", handler: { (action) in
            print("Option 1 was selected")
        }), UIAction(title: "Option 2", handler: { (action) in
            print("Option 2 was selected")
        }), UIAction(title: "Option 3", handler: { (action) in
            print("Option 3 was selected")
        })])
    }
    override func viewWillAppear(_ animated: Bool) {
        configureTapMeButtonMenu()
    }
    @IBAction func tapMenuBtn(_ sender: Any) {
        configureTapMeButtonMenu()
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
