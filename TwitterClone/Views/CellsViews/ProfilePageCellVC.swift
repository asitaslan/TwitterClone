//
//  ProfilePageCellVCTableViewCell.swift
//  TwitterClone
//
//  Created by Asit Aslan on 3.03.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit

class ProfilePageCellVC: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func commentButtonClicked(_ sender: UIButton) {
    }
    
    @IBAction func retweetButtonClicked(_ sender: UIButton) {
    }
    @IBAction func likeButtonClicked(_ sender: UIButton) {
    }
    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
    }
    
}
