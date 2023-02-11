//
//  UIButtonExtension.swift
//  Deterview
//
//  Created by MIJU on 2022/12/11.
//

import Foundation
import UIKit

extension UIButton {
    func setFontStyle(size: CGFloat, weight: UIFont.Weight) {
        guard let text = titleLabel?.text else { return }
        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size, weight: weight)]
        let attributedTitle = NSAttributedString(string: text, attributes: attribute)
        self.setAttributedTitle(attributedTitle, for: .normal)
    }
}
