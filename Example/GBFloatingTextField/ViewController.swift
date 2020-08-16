//
//  ViewController.swift
//  GBFloatingTextField
//
//  Created by mr.gsbatth@gmail.com on 10/07/2018.
//  Copyright (c) 2018 mr.gsbatth@gmail.com. All rights reserved.
//

import UIKit
import GBFloatingTextField

class ViewController: UIViewController, GBTextFieldDelegate {

    var textField: GBTextField!
    
    var isError: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField = GBTextField(frame: CGRect(x:10, y: 250, width: UIScreen.main.bounds.width - 20, height: 40))
        textField.selectedLineColor = .yellow
        textField.leftImage = #imageLiteral(resourceName: "email")
        textField.rightImageSquare = #imageLiteral(resourceName: "email")
        textField.placeholder = "Hello"
        textField.text = "Check Data"
        self.textField.showErrorMessage(isError, "Test Error")
        self.textField.textColor = .brown
        textField.gbTextFieldDelegate = self
        textField.titleLabelColor = .black
        textField.lineHeight = 1
        textField.lineColor = .gray
        textField.textColor = .green
        self.view.addSubview(textField)
    }

    func gbLeftView(_ textField: GBTextField?) {
        print("Left View Clicked")
    }
    
    @IBAction func btnHideShow(_ sender: Any){
        self.isError.toggle()
        self.textField.showErrorMessage(isError, "Test Error")
    }
    
    @IBAction func btnResignTextField(_ sender: Any){
        self.textField.resignFirstResponder()
    }
    
}

