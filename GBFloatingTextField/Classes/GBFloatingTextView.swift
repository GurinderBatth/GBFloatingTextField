//
//  GBTextView.swift
//  FloatingTextField
//
//  Created by Apple on 25/10/18.
//  Copyright © 2018 Batth. All rights reserved.
//

import UIKit

@IBDesignable
public class GBFloatingTextView: UITextView {
    
    @IBInspectable public var isFloatingLabel: Bool = false{
        didSet{
            if isFloatingLabel{
                self.placeholderLabel.isHidden = false
                self.addFloatingLabel()
                if constraintPlaceholderLabelTop != nil{
                    constraintPlaceholderLabelTop.constant = 15
                }
                if self.text.count > 0{
                    self.refreshPlaceholder()
                }
            }
        }
    }
    
    @IBInspectable public var placeholder: String?{
        didSet{
            self.setPlaceholderLabel()
            #if swift(>=4.2)
            let UITextViewTextDidChange = UITextView.textDidChangeNotification
            let UITextViewTextBeginEditing = UITextView.textDidBeginEditingNotification
            let UITextViewTextEndEditing = UITextView.textDidEndEditingNotification
            #else
            let UITextViewTextDidChange = Notification.Name.UITextViewTextDidChange
            let UITextViewTextBeginEditing = Notification.Name.UITextViewTextDidBeginEditing
            let UITextViewTextEndEditing = Notification.Name.UITextViewTextDidEndEditing
            
            #endif
            NotificationCenter.default.addObserver(self, selector: #selector(self.refreshPlaceholder), name:UITextViewTextDidChange, object: self)
            NotificationCenter.default.addObserver(self, selector: #selector(self.beginEditing), name:UITextViewTextBeginEditing, object: self)
            NotificationCenter.default.addObserver(self, selector: #selector(self.textEndEditing), name:UITextViewTextEndEditing, object: self)
            
        }
    }
    
    @IBInspectable public var placeholderColor: UIColor? = .lightGray{
        didSet{
            placeholderLabel.textColor = placeholderColor
            if topPlaceholderColor == nil{
                self.topPlaceholderColor = placeholderColor
            }
        }
    }
    
    @IBInspectable public var topPlaceholderColor: UIColor? = .lightGray{
        didSet{
            if self.selectedColor == nil{
                self.selectedColor = topPlaceholderColor
            }
        }
    }
    
    @IBInspectable public var selectedColor: UIColor?
    
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
    
    init(frame: CGRect, superView: UIView) {
        super.init(frame: frame, textContainer: nil)
        superView.addSubview(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK:-  Private Properties
    private var constraintPlaceholderLabelTop: NSLayoutConstraint!
    
    var isSetupPlaceholder:Bool = false
    
    //MARK:-  Private Functions
    private lazy var placeholderLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.numberOfLines = 0
        lbl.font = self.font
        return lbl
    }()
    
    private func setPlaceholderLabel(){
        self.isSetupPlaceholder = true
        print(self.text)
        placeholderLabel.text = placeholder
        placeholderLabel.textColor = placeholderColor ?? .lightGray
        placeholderLabel.textAlignment = self.textAlignment
        self.superview?.addSubview(placeholderLabel)
        placeholderLabel.font = self.font
        if self.font == nil{
            placeholderLabel.font = UIFont.systemFont(ofSize: 14)
        }
        constraintPlaceholderLabelTop = placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8)
        constraintPlaceholderLabelTop.isActive = true
        if isFloatingLabel{
            constraintPlaceholderLabelTop.constant = 15
        }
        placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        placeholderLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -10).isActive = true
        if self.text.count > 0{
            if !isFloatingLabel{
                self.placeholderLabel.isHidden = true
            }
            self.refreshPlaceholder()
        }
    }
    
    private func addFloatingLabel(){
        #if swift(>=4.2)
        self.textContainerInset = UIEdgeInsets(top: 15, left: 5, bottom: 15, right: 10)
        #else
        self.textContainerInset = UIEdgeInsetsMake(15, 5, 15, 10)
        #endif
        self.layoutIfNeeded()
    }
    
    //MARK:-  Notification
    @objc func refreshPlaceholder(){
        if self.text.count > 0{
            if isFloatingLabel{
                if self.constraintPlaceholderLabelTop.constant != 0{
                    self.placeholderLabel.animate(font: UIFont(name: self.font?.fontName ?? "Helvetica-Neue", size: 12) ?? UIFont.boldSystemFont(ofSize: 12), duration: 0.3)
                    self.constraintPlaceholderLabelTop.constant = 0
                    self.placeholderLabel.backgroundColor = .clear
                    UIView.animate(withDuration: 0.3, animations: {
                        self.superview?.layoutIfNeeded()
                    })
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.placeholderLabel.backgroundColor = self.backgroundColor
                        if self.selectedColor == nil{
                            self.selectedColor = self.topPlaceholderColor
                        }
                        if self.isFirstResponder{
                            self.placeholderLabel.textColor = self.selectedColor
                        }else{
                            self.placeholderLabel.textColor = self.topPlaceholderColor
                        }
                    }
                }
            }else{
                self.placeholderLabel.isHidden = true
            }
        }else{
            if isFloatingLabel{
                self.placeholderLabel.animate(font: self.font ?? UIFont.systemFont(ofSize: 17), duration: 0.3)
                self.constraintPlaceholderLabelTop.constant = 15
                self.placeholderLabel.backgroundColor = .clear
                UIView.animate(withDuration: 0.3) {
                    self.superview?.layoutIfNeeded()
                    self.placeholderLabel.textColor = self.placeholderColor
                }
            }else{
                self.placeholderLabel.textColor = self.placeholderColor
                self.placeholderLabel.isHidden = false
            }
        }
    }
    
    @objc func beginEditing(){
        if text.count > 0{
            self.placeholderLabel.textColor = selectedColor
        }
    }
    
    @objc func textEndEditing(){
        if text.count > 0{
            self.placeholderLabel.textColor = topPlaceholderColor
        }else{
            self.placeholderLabel.textColor = placeholderColor
        }
    }
}
