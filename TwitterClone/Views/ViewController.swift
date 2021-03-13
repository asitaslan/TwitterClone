//
//  ViewController.swift
//  TwitterClone
//
//  Created by Asit Aslan on 22.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func logInButton(_ sender: UIButton) {
        
        performSegue(withIdentifier: "toFeedVC", sender: nil)
        
        
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        
        let signUpVC = self.storyboard?.instantiateViewController(identifier: "SignUpVC") as! SignUpVC
        self.present(signUpVC, animated: false, completion: nil)
    }
}


