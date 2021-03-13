//
//  UploadViewController.swift
//  TwitterClone
//
//  Created by Asit Aslan on 28.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var pestTextInput: UITextView!
    @IBOutlet weak var uploadVCprofilePhoto: UIImageView!
    @IBOutlet weak var uploadImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tweetButton.layer.cornerRadius = 10.0
        tweetButton.clipsToBounds = true
    }
    
    @IBAction func backFeedVCButton(_ sender: UIButton) {
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "toTabBarVC") as! UITabBarController
        self.present(homeVC, animated: true, completion: nil)
        
    }
    
    @IBAction func tweetButtonClicked(_ sender: UIButton) {
        backFeedVCButton(tweetButton)
    }
    
    @IBAction func selectPhotoButton(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    

}
