//
//  UITextView.swift
//  Deterview
//
//  Created by 조석진 on 2022/12/27.
//
import UIKit

extension UITextView {
    func newHeight(withBaseHeight baseHeight: CGFloat) -> CGFloat {
        let fixedHeight = baseHeight
        var newFrame = frame
        newFrame.size.height = CGFloat(fixedHeight)
        
        return newFrame.height
    }
}
