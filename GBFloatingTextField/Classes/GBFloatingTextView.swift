//
//  GBTextView.swift
//  FloatingTextField
//
//  Created by Apple on 25/10/18.
//  Copyright © 2018 Batth. All rights reserved.
//

import UIKit

@IBDesignable
public class GBFloatingTextView:UITextView{
    
    @IBInspectable public var placeholder: String?{
        didSet{
            self.setPlaceholderLabel()
            #if swift(>=4.2)
            let UITextViewTextDidChange = UITextView.textDidChangeNotification
            #else
            let UITextViewTextDidChange = Notification.Name.UITextViewTextDidChange
            #endif
            NotificationCenter.default.addObserver(self, selector: #selector(self.refreshPlaceholder), name:UITextViewTextDidChange, object: self)
        }
    }
    
    @IBInspectable public var placeholderColor: UIColor?{
        didSet{
            placeholderLabel.textColor = placeholderColor
        }
    }
    
    @IBInspectable public var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable public var borderColor: UIColor = .lightGray{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
//MARK:-  Private Functions
    private lazy var placeholderLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = self.font
        return lbl
    }()
    
    private func setPlaceholderLabel(){
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = placeholderColor ?? .lightGray
        placeholderLabel.textAlignment = self.textAlignment
        self.addSubview(placeholderLabel)
        placeholderLabel.font = self.font
        if self.font == nil{
            placeholderLabel.font = UIFont.systemFont(ofSize: 14)
        }
        placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        placeholderLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -10).isActive = true
        if self.text.count > 0{
            self.placeholderLabel.isHidden = true
        }
    }
    
//MARK:-  Notification
    @objc func refreshPlaceholder(){
        print(self.text)
        if self.text.count > 0{
            self.placeholderLabel.isHidden = true
        }else{
            self.placeholderLabel.isHidden = false
        }
    }
}
