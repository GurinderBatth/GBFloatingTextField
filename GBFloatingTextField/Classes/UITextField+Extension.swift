//
//  UITextField+Extension.swift
//  GBFloatingTextField
//
//  Created by Apple on 28/10/18.
//

import Foundation

extension UITextField {
    func fixSecureEntry() {
        let beginning = beginningOfDocument
        selectedTextRange = textRange(from: beginning, to: beginning)
        let end = endOfDocument
        selectedTextRange = textRange(from: end, to: end)
    }
}
