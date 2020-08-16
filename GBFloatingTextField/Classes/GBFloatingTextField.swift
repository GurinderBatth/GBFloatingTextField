//
//  GBTextField.swift
//  Post
//
//  Created by Batth on 07/10/18.
//  Copyright © 2018 Gurinder Batth. All rights reserved.
//

import UIKit

public protocol GBTextFieldDelegate: class{
    func gbLeftView(_ textField: GBTextField?)
    func gbRightView(_ textField: GBTextField?)
}

public extension GBTextFieldDelegate{
    func gbLeftView(_ textField: GBTextField?){
        print("Please add GBTextFieldDelegate & gbLeftView(_ textField: GBTextField?) function")
    }
    func gbRightView(_ textField: GBTextField?){
        print("Please add GBTextFieldDelegate & gbRightView(_ textField: GBTextField?) function")
    }
}

@IBDesignable
public class GBTextField: UITextField {
    
    //MARK:-  Public Properties
    public weak var gbTextFieldDelegate: GBTextFieldDelegate?
    
    @IBInspectable
    public var lineHeight: CGFloat = 0{
        didSet{
            setupLine()
        }
    }
    
    @IBInspectable
    public var selectedLineHeight: CGFloat = 0{
        didSet{
            if selectedLineHeight == 0{
                selectedLineHeight = lineHeight
            }
        }
    }
    
    @IBInspectable
    public var labelText: String = ""{
        didSet{
            if labelText != ""{
                self.labelPlaceholder.text = labelText
            }
        }
    }
    
    @IBInspectable
    public var titleLabelColor: UIColor = .darkGray
    
    public var titleFont: UIFont?{
        didSet{
            self.labelPlaceholder.font = titleFont
        }
    }
    
    @IBInspectable
    public var lineColor: UIColor = .darkGray{
        didSet{
            if !showError {
                self.viewLine?.backgroundColor = lineColor
            }else{
                self.viewLine?.backgroundColor = errorColor
            }
        }
    }
    
    @IBInspectable
    public var selectedTitleColor: UIColor = .blue
    
    @IBInspectable
    public var selectedLineColor: UIColor = .blue
    
    @IBInspectable
    public var errorColor: UIColor = .red{
        didSet{
            self.labelError.textColor = errorColor
            if showError {
                self.showErrorMessage(self.showError, self.errorMessage ?? "")
            }
        }
    }
    
    public var errorFont: UIFont?{
        didSet{
            self.labelError.font = errorFont
        }
    }
    
    @IBInspectable
    public var placeholderColor: UIColor?{
        didSet{
            #if swift(>=4.2)
                self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedString.Key.foregroundColor:placeholderColor ?? UIColor.lightGray])

            #elseif swift(>=4.0)
                self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSAttributedStringKey.foregroundColor:placeholderColor ?? UIColor.lightGray])
            #else
                self.attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: [NSForegroundColorAttributeName:placeholderColor ?? UIColor.lightGray])
            #endif
        }
    }
    
    @IBInspectable
    public var rightImage: UIImage?{
        didSet{
            let ratio = (rightImage?.size.height)! / (rightImage?.size.width)!
            let newWidth = self.frame.height / ratio
            
            viewRight = UIView(frame: CGRect(x: 0, y: 0, width: newWidth, height: self.frame.size.height))
            if viewRight != nil{
                viewRight!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rightViewSelected(_:))))
            }
            let imageView = UIImageView(image: rightImage)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.isUserInteractionEnabled = true
            viewRight?.addSubview(imageView)
            
            imageView.topAnchor.constraint(equalTo: viewRight!.topAnchor, constant: 7).isActive = true
            imageView.leftAnchor.constraint(equalTo: viewRight!.leftAnchor, constant: 7).isActive = true
            imageView.bottomAnchor.constraint(equalTo: viewRight!.bottomAnchor, constant: -7).isActive = true
            imageView.rightAnchor.constraint(equalTo: viewRight!.rightAnchor, constant: -7).isActive = true
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleToFill
            self.rightView = viewRight
            self.rightViewMode = .always
        }
    }
    
    @IBInspectable
    public var rightImageSquare: UIImage?{
        didSet{
            var newWidth: CGFloat = 20
            if self.frame.height > 25 && self.frame.height < 30{
                newWidth = 25
            }else if self.frame.height >= 30{
                newWidth = 30
            }
            let x = viewRight?.frame.origin.x ?? 0
            let y = viewRight?.frame.origin.y ?? 0
            viewRight = UIView(frame: CGRect(x: x, y: y, width: newWidth, height: newWidth))
            if viewRight != nil{
                viewRight!.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rightViewSelected(_:))))
            }
            let imageView = UIImageView(image: rightImageSquare)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.isUserInteractionEnabled = true
            viewRight?.addSubview(imageView)
            
            imageView.rightAnchor.constraint(equalTo: viewRight!.rightAnchor, constant: -5).isActive = true
            imageView.leftAnchor.constraint(equalTo: viewRight!.leftAnchor, constant: 5).isActive = true
            imageView.centerYAnchor.constraint(equalTo: self.viewRight!.centerYAnchor).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: CGFloat(newWidth - 5)).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: CGFloat(newWidth - 5)).isActive = true
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFit
            self.rightView = viewRight
            self.rightViewMode = .always
        }
    }
    
    @IBInspectable
    public var padding: CGFloat = 0{
        didSet{
            if rightImage == nil{
                self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
                self.rightViewMode = .always
            }
            if leftImage == nil{
                self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.frame.height))
                self.leftViewMode = .always
            }
        }
    }
    
    @IBInspectable
    public var leftImage: UIImage?{
        didSet{
            let ratio = (leftImage?.size.height)! / (leftImage?.size.width)!
            let newWidth = self.frame.height / ratio
            viewLeft = UIView(frame: CGRect(x: 0, y: 0, width: newWidth, height: self.frame.size.height))
            if viewLeft != nil{
                viewLeft?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(leftViewSelected(_:))))
            }
            let imageView = UIImageView(image: leftImage)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.isUserInteractionEnabled = true
            viewLeft?.addSubview(imageView)
            
            imageView.topAnchor.constraint(equalTo: viewLeft!.topAnchor, constant: 7).isActive = true
            imageView.leftAnchor.constraint(equalTo: viewLeft!.leftAnchor, constant: 7).isActive = true
            imageView.bottomAnchor.constraint(equalTo: viewLeft!.bottomAnchor, constant: -7).isActive = true
            imageView.rightAnchor.constraint(equalTo: viewLeft!.rightAnchor, constant: -7).isActive = true
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleToFill
            self.leftView = viewLeft
            self.leftViewMode = .always
        }
    }
    
    @IBInspectable
    public var leftImageSquare: UIImage?{
        didSet{
            var newWidth = 20
            if self.frame.height > 25 && self.frame.height < 30{
                newWidth = 25
            }else if self.frame.height >= 30{
                newWidth = 30
            }
            viewLeft = UIView(frame: CGRect(x: 0, y: 0, width: newWidth + 14, height: newWidth))
            if viewLeft != nil{
                viewLeft?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(leftViewSelected(_:))))
            }
            let imageView = UIImageView(image: leftImageSquare)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.isUserInteractionEnabled = true
            viewLeft?.addSubview(imageView)
            imageView.leftAnchor.constraint(equalTo: viewLeft!.leftAnchor, constant: 5).isActive = true
            imageView.rightAnchor.constraint(equalTo: viewLeft!.rightAnchor, constant:-5).isActive = true
            imageView.centerYAnchor.constraint(equalTo: self.viewLeft!.centerYAnchor).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: CGFloat(newWidth - 5)).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: CGFloat(newWidth - 5)).isActive = true
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFit
            self.leftView = viewLeft
            self.leftViewMode = .always
        }
    }
    
    
    public var rightImageClicable: Bool = false{
        didSet{
            if rightImageClicable{
                viewRight?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(rightViewSelected(_:))))
            }
        }
    }
    
    public var leftImageClicable: Bool = false{
        didSet{
            if leftImageClicable{
                viewLeft?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(leftViewSelected(_:))))
            }
        }
    }
    
//MARK:-  Private Properties
    private var viewRight: UIView?
    private var viewLeft: UIView?
    
    private var textString: String?
    private var errorMessage: String?
    
    private var defaultTextColor: UIColor?
    
    private lazy var viewLine:UIView? = {
        let prntView = UIView()
        prntView.translatesAutoresizingMaskIntoConstraints = false
        return prntView
    }()
    
    private lazy var labelPlaceholder: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .clear
        lbl.font = self.font
        return lbl
    }()
    
    private lazy var labelError: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = self.font
        lbl.textAlignment = .right
        lbl.numberOfLines = 0
        lbl.font = UIFont.boldSystemFont(ofSize: 12)
        return lbl
    }()
    
    private var constraintFloatingLabelTop: NSLayoutConstraint!
    private var constraintFloatingLabelLeft: NSLayoutConstraint!
    private var constraintFloatingLabelHeight: NSLayoutConstraint!
    private var constraintLineHeight: NSLayoutConstraint?
    
    private var showError: Bool = false{
        didSet{
            if showError{
                self.setupError()
            }else{
                if isEditing{
                    self.viewLine?.backgroundColor = selectedLineColor
                    self.labelPlaceholder.textColor = selectedTitleColor
                }else{
                    self.viewLine?.backgroundColor = lineColor
                    self.labelPlaceholder.textColor = titleLabelColor
                }
                self.textColor = self.defaultTextColor
                self.labelError.isHidden = true
            }
        }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.addViews()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.addViews()
    }
    
    public override func prepareForInterfaceBuilder() {
        self.addViews()
    }
    
    public override var text: String?{
        set{
            self.textString = newValue
            super.text = newValue
            if !(newValue?.isEmpty ?? true){
                self.showFloatingLabel()
            }
        }get{
            return super.text
        }
    }
    
    public override var textColor: UIColor?{
        set{
            if newValue != errorColor {
                self.defaultTextColor = newValue
            }
            if !self.showError{
                super.textColor = newValue
            }else{
                super.textColor = self.errorColor
            }
        }get{
            return super.textColor
        }
    }
    
    public func showErrorMessage(_ showError: Bool = true, _ error: String = ""){
        if showError {
            self.errorMessage = error
            self.setupError()
            self.labelError.isHidden = false
            labelError.textColor = errorColor
            labelError.text = error
            viewLine?.backgroundColor = errorColor
            self.textColor = errorColor
            self.labelPlaceholder.textColor = errorColor
        }
        self.showError = showError
        if (self.text?.isEmpty ?? true){
            self.hideFloatingLabel()
        }
    }
    
//MARK:-  Private Functions
    
    @objc private func rightViewSelected(_ gesture: UITapGestureRecognizer){
        let textField = gesture.view?.superview as? GBTextField
        self.gbTextFieldDelegate?.gbRightView(textField)
    }
    
    @objc private func leftViewSelected(_ gesture: UITapGestureRecognizer){
        let textField = gesture.view?.superview as? GBTextField
        self.gbTextFieldDelegate?.gbLeftView(textField)
    }
    
    private func addViews(){
        self.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        for subView in self.subviews{
            if subView == labelPlaceholder{
                return
            }
        }
        addSubview(labelPlaceholder)
        if labelText != ""{
            labelPlaceholder.text = labelText
        }else{
            labelPlaceholder.text = placeholder
        }
        self.constraintFloatingLabelTop = self.labelPlaceholder.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        self.constraintFloatingLabelTop.isActive = true
        self.labelPlaceholder.leftAnchor.constraint(equalTo: self.leftView?.rightAnchor ?? self.leftAnchor).isActive = true
        self.labelPlaceholder.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.constraintFloatingLabelHeight = self.labelPlaceholder.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 0)
        self.constraintFloatingLabelHeight.isActive = true
        self.labelPlaceholder.textAlignment = self.textAlignment
        if (self.text?.count ?? 0) > 0{
            self.setupLine()
            self.textFieldDidChange(self)
            self.resignFirstResponder()
        }
        self.defaultTextColor = self.textColor
    }
    
    private func setupLine(){
        if lineHeight != 0{
            for subview in self.subviews{
                if subview == self.viewLine{
                    return
                }
            }
            if viewLine != nil{
                addSubview(self.viewLine!)
                viewLine?.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
                viewLine?.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
                viewLine?.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
                constraintLineHeight = viewLine?.heightAnchor.constraint(equalToConstant: lineHeight)
                viewLine?.backgroundColor = lineColor
                constraintLineHeight?.isActive = true
            }
        }
    }
    
    private func setupError(){
        for subview in self.subviews{
            if subview == self.labelError{
                return
            }
        }
        addSubview(self.labelError)
        labelError.topAnchor.constraint(equalTo: self.bottomAnchor, constant: lineHeight + 3).isActive = true
        labelError.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        labelError.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        labelError.textColor = errorColor
    }
    
    public override var isSecureTextEntry: Bool{
        set{
            super.isSecureTextEntry = newValue
            fixSecureEntry()
        }get{
            return super.isSecureTextEntry
        }
    }
    
    @discardableResult
    override public func becomeFirstResponder() -> Bool {
        self.setupLabelText()
        if !showError{
            self.viewLine?.backgroundColor = selectedLineColor
        }
        let count = self.text?.count ?? 0
        if count == 0{
            return super.becomeFirstResponder()
        }
        
        if selectedLineHeight == 0{
            constraintLineHeight?.constant = lineHeight
        }else{
            constraintLineHeight?.constant = selectedLineHeight
        }
        
        if count > 0{
            self.labelPlaceholder.textColor = selectedTitleColor
            if showError{
                viewLine?.backgroundColor = errorColor
                labelPlaceholder.textColor = errorColor
            }
            self.showFloatingLabel()
            if self.showError{
                self.labelPlaceholder.textColor = self.errorColor
            }else{
                self.labelPlaceholder.textColor = self.selectedTitleColor
            }
        }
        return super.becomeFirstResponder()
    }
    
    @discardableResult
    override public func resignFirstResponder() -> Bool {
        constraintLineHeight?.constant = lineHeight
        self.viewLine?.backgroundColor = lineColor
        if let count = self.text?.count{
            if count > 0{
                self.labelPlaceholder.textColor = titleLabelColor
            }else{
                self.labelPlaceholder.textColor = .clear
            }
            if showError{
                viewLine?.backgroundColor = errorColor
                labelPlaceholder.textColor = errorColor
            }
        }else{
            self.labelPlaceholder.textColor = .clear
        }
        return super.resignFirstResponder()
    }
    
    @objc private func textFieldDidChange(_ textField:UITextField){
        if let text = self.text{
            if text.count > 0{
                labelPlaceholder.isHidden = false
                if self.constraintFloatingLabelTop.constant != -15{
                    self.showFloatingLabel()
                }
            }else{
                self.hideFloatingLabel()
            }
        }
    }
    
    private func setupLabelText(){
        if labelText != ""{
            labelPlaceholder.text = labelText
        }else{
            labelPlaceholder.text = placeholder
        }
        if (self.text?.isEmpty ?? true){
           self.hideFloatingLabel()
        }
    }
    
    private func showFloatingLabel(){
        self.setupLabelText()
        self.constraintFloatingLabelHeight.isActive = false
        self.constraintFloatingLabelTop.constant = -15
        self.labelPlaceholder.font = UIFont.boldSystemFont(ofSize: 12)
        if self.showError{
            self.labelPlaceholder.textColor = self.errorColor
        }else{
            if self.isEditing{
                self.labelPlaceholder.textColor = self.selectedTitleColor
            }else{
                self.labelPlaceholder.textColor = self.titleLabelColor
            }
        }
        UIView.transition(with: self.labelPlaceholder, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.layoutIfNeeded()
        }) { (completed) in
            
        }
    }
    
    private func hideFloatingLabel(){
        self.constraintFloatingLabelHeight.isActive = false
        self.constraintFloatingLabelHeight = self.labelPlaceholder.heightAnchor.constraint(equalTo: self.heightAnchor, constant: 0)
        self.constraintFloatingLabelHeight.isActive = true
        self.constraintFloatingLabelTop.constant = 20
        UIView.transition(with: self.labelPlaceholder, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.layoutIfNeeded()
            self.labelPlaceholder.font = self.font
            self.labelPlaceholder.textColor = .clear
        }) { (completed) in
            
        }
    }
}
