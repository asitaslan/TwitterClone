//
//  MessagesVC.swift
//  TwitterClone
//
//  Created by Asit Aslan on 24.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit

class MessagesVC: UIViewController {

    @IBOutlet weak var addMessageButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addMessageButton.layer.cornerRadius = addMessageButton.frame.size.width/2
        addMessageButton.layer.masksToBounds = true
        
    }
    

    @IBAction func addMessageButtonClicked(_ sender: Any) {
    }
    
}
