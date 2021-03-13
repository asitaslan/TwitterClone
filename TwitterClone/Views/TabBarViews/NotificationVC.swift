//
//  NotificationVC.swift
//  TwitterClone
//
//  Created by Asit Aslan on 24.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit

class NotificationVC: BaseViewController {

    @IBOutlet weak var addPostButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addPostButton.layer.cornerRadius = addPostButton.frame.size.width/2
        addPostButton.layer.masksToBounds = true
    }
    

    @IBAction func addPostClicked(_ sender: Any) {
        goUploadPost()
    }
    

}
