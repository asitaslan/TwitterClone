//
//  LogOutVC.swift
//  TwitterClone
//
//  Created by Asit Aslan on 23.03.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit
import Firebase

class LogOutVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logOutButtonClicked(_ sender: UIButton) {
        
        do {
            try Auth.auth().signOut()
            let toSignIn = self.storyboard?.instantiateViewController(identifier: "toSignInVC") as! ViewController
            self.present(toSignIn, animated: true, completion: nil)
            
        }catch{
                
        }
        }

}
