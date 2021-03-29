//
//  ProfilePageVC.swift
//  TwitterClone
//
//  Created by Asit Aslan on 2.03.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit
import SDWebImage
class ProfilePageVC: BaseViewController {

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
        viewWillAppear(true)
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      userInfo()
    }
    
    func setupUI(){
        self.profilePageProfileImage.cornerRadius(radius: profilePageProfileImage.frame.size.width/2)
    }
    
    @IBAction func updateProfileButtonClicked(_ sender: UIButton) {
        
        let goUpdatePage = self.storyboard?.instantiateViewController(withIdentifier: "UpdateProfil") as! UpdateProfil
        self.navigationController?.pushViewController(goUpdatePage, animated: true)
        
    }
    
    func userInfo(){
        Network.getUserInfo(completion: { (result) in
        if result{
            self.profilePageNameLbl.text = UserInfo.sharedUserInfo.Name
            self.profilePageProfileImage.sd_setImage(with: URL(string: UserInfo.sharedUserInfo.imageUrl))
            self.profilePageUserNameLbl.text = UserInfo.sharedUserInfo.userName
        }
            
        }) { (error) in
            self.makeAlert(textInput: "ERROR", messageInput: error.localizedDescription)
        }
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
