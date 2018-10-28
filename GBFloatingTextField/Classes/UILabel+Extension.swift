//
//  UILabel+Extension.swift
//  GBFloatingTextField
//
//  Created by Apple on 28/10/18.
//

import Foundation

//MARK:-  Help From https://stackoverflow.com/a/39415143/6655153
//Thanks :- Mixel( https://stackoverflow.com/users/746347/mixel)
extension UILabel {
    func animate(font: UIFont, duration: TimeInterval) {
        let oldFrame = frame
        let labelScale = self.font.pointSize / font.pointSize
        self.font = font
        let oldTransform = transform
        transform = transform.scaledBy(x: labelScale, y: labelScale)
        let newOrigin = frame.origin
        if self.textAlignment == .left || self.textAlignment == .natural{
            frame.origin = oldFrame.origin // only for left aligned text
        }
        if self.textAlignment == .right{
            frame.origin = CGPoint(x: oldFrame.origin.x + oldFrame.width - frame.width, y: oldFrame.origin.y) // only for right aligned text
        }
        setNeedsUpdateConstraints()
        UIView.animate(withDuration: duration) {
            self.frame.origin = newOrigin
            self.transform = oldTransform
            self.layoutIfNeeded()
        }
    }
}
