//
//  ViewController.swift
//  TwitterClone
//
//  Created by Asit Aslan on 22.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit
import Firebase
class ViewController: BaseViewController {

    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
      
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func logInButton(_ sender: UIButton) {
        if emailTxt.text != "" && passwordTxt.text != "" {
                 Auth.auth().signIn(withEmail: emailTxt.text!, password: passwordTxt.text!) { (result, error) in
                     if error != nil{
                        self.makeAlert(textInput: "ERROR", messageInput: error?.localizedDescription ?? "Error")
                     }else{
                        self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                     }
                 }
              }else{
                   self.makeAlert(textInput: "ERROR", messageInput: "email/Password")
        }
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        let signUpVC = self.storyboard?.instantiateViewController(identifier: "SignUpVC") as! SignUpVC
        self.present(signUpVC, animated: false, completion: nil)
    }
}


