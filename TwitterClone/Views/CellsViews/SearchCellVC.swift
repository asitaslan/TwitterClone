//
//  SearchCellVC.swift
//  TwitterClone
//
//  Created by Asit Aslan on 27.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit

class SearchCellVC: UITableViewCell {

    @IBOutlet weak var serachProfileImage: UIImageView!
    @IBOutlet weak var searchNameLbl: UILabel!
    @IBOutlet weak var searchUsernameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        serachProfileImage.layer.cornerRadius = serachProfileImage.frame.size.width/2
        serachProfileImage.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
