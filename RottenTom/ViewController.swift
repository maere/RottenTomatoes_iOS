//
//  ViewController.swift
//  RottenTom
//
//  Created by MSSSD on 9/26/15.
//  Copyright © 2015 MSSSD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
   
    @IBOutlet weak var textField: UITextField!


    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didTapUpdate(sender: UIButton) {
        //this is to swap text in field to lable
        
        let currentText = self.textField.text
        self.textLabel.text = currentText
        
        
        //this is to debug
        NSLog("Did Tap Update button")
    }

}

