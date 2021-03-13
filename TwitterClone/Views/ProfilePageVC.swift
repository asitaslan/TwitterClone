//
//  ProfilePageVC.swift
//  TwitterClone
//
//  Created by Asit Aslan on 2.03.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit

class ProfilePageVC: UIViewController {

    @IBOutlet weak var profilePageProfileImage: UIImageView!
    @IBOutlet weak var profilePageNameLbl: UILabel!
    @IBOutlet weak var profilePageUserNameLbl: UILabel!
    @IBOutlet weak var updateProfileButton: UIButton!
    @IBOutlet weak var tweetsViewProfilePage: UIView!
    @IBOutlet weak var likesViewProfilePage: UIView!
    @IBOutlet weak var profilePageTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profilePageTableView.delegate = self
        profilePageTableView.dataSource = self
    }
    
    @IBAction func updateProfileButtonClicked(_ sender: UIButton) {
        
    }
}

extension ProfilePageVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = profilePageTableView.dequeueReusableCell(withIdentifier: "toProfilePageCell", for: indexPath) as! ProfilePageCellVC
        return cell
    }
    
    
}
