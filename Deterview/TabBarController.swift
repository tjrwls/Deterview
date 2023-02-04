//
//  ViewController.swift
//  Deterview
//
//  Created by 조석진 on 2022/11/29.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.backgroundColor = .white
        self.tabBar.barTintColor = .white
        self.tabBar.tintColor = UIColor(named: "mainColor")
    }
}
