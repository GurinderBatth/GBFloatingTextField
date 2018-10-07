//
//  ViewController.swift
//  GBFloatingTextField
//
//  Created by mr.gsbatth@gmail.com on 10/07/2018.
//  Copyright (c) 2018 mr.gsbatth@gmail.com. All rights reserved.
//

import UIKit
import GBFloatingTextField

class ViewController: UIViewController {

    var textField: GBTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField = GBTextField(frame: CGRect(x:10, y: 100, width: UIScreen.main.bounds.width - 20, height: 40))
        textField.lineColor = .black
        textField.titleLabelColor = .black
        textField.lineHeight = 1
        textField.showErrorMessage("This is Text Error")
        self.view.addSubview(textField)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

