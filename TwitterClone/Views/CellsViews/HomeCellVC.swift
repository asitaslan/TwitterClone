//
//  HomeCellVC.swift
//  TwitterClone
//
//  Created by Asit Aslan on 24.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit

protocol GoProfilePage : class{
    func changeImage()
}


class HomeCellVC: UITableViewCell {

    @IBOutlet weak var profileImageCellView: UIImageView!
    @IBOutlet weak var nameSuenameLbl: UILabel!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postTimeLbl: UILabel!
    @IBOutlet weak var postViewLbl: UILabel!
    @IBOutlet weak var postImageView1: UIImageView!
    @IBOutlet weak var commandCountLbl: UILabel!
    @IBOutlet weak var retweetCountLbl: UILabel!
    @IBOutlet weak var likeCountLbl: UILabel!
    weak var delegate: GoProfilePage?
    var count: Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cornerRadius()
        profileImageGesture()
        
    }
    
    func profileImageGesture(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(profileImageClicked))
        profileImageCellView.addGestureRecognizer(gesture)
        profileImageCellView.isUserInteractionEnabled = true
    }
    
    @objc func profileImageClicked(){
        delegate?.changeImage()
    }
    
    func cornerRadius(){
        profileImageCellView.layer.cornerRadius = profileImageCellView.frame.size.width/2
        profileImageCellView.layer.masksToBounds = true
        postImageView1.layer.cornerRadius = 10.0
        postImageView1.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   
    @IBAction func commendButton(_ sender: UIButton) {
        print("command button is running")
    }
    
    @IBAction func retweetButton(_ sender: UIButton) {
          print("retweet button is running")
    }
    
    @IBAction func likeButton(_ sender: UIButton) {
     
        sender.isSelected.toggle()
        if sender.isSelected{
            count += 1
        }else{
            count -= 1
        }
        likeCountLbl.text = String(count)
    }
    
    @IBAction func sendButton(_ sender: UIButton) {
          print("send button is running")
    }
    
}
