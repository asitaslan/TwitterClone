//
//  UpdateProfil.swift
//  TwitterClone
//
//  Created by Asit Aslan on 28.03.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit
import Firebase
class UpdateProfil: BaseViewController {

    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameTextInput: UITextField!
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI(){
        updateButton.cornerRadius(radius: 8.0)
    }
    
    @IBAction func updateButtonCliced(_ sender: UIButton) {
        Network.updateUser(name: self.nameTextInput.text, userNmae: self.userNameInput.text, profileImage: "", backImage: "", complition: { (result) in
            if result{
                
            }
        }) { (error) in
            self.makeAlert(textInput: "ERROR", messageInput: error.localizedDescription)
        }
    }
    
}
