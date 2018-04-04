//
//  ViewController.swift
//  uberTest
//
//  Created by LayYuan on 04/04/2018.
//  Copyright © 2018 justCodeEnterprise. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var driverLabel: UILabel!
    @IBOutlet weak var riderLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var riderDriverSwitch: UISwitch!
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    var signUpMode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func topTapped(_ sender: Any) {
    }
    
    
    @IBAction func bottomTapped(_ sender: Any) {
        
        if signUpMode {
            topButton.setTitle("Log In", for: .normal)
            bottomButton.setTitle("Switch to Sign UP", for: .normal)
            riderDriverSwitch.isHidden = true
            riderLabel.isHidden = true
            driverLabel.isHidden = true
            signUpMode = false
        }else {
            topButton.setTitle("Sign Up", for: .normal)
            bottomButton.setTitle("Switch to Log In", for: .normal)
            riderDriverSwitch.isHidden = false
            riderLabel.isHidden = false
            driverLabel.isHidden = false
            signUpMode = true
        }
    }
    
}

