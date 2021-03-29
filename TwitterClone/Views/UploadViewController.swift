//
//  UploadViewController.swift
//  TwitterClone
//
//  Created by Asit Aslan on 28.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit
import Firebase

class UploadViewController: BaseViewController{

    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var pestTextInput: UITextView!
    @IBOutlet weak var uploadVCprofilePhoto: UIImageView!
    @IBOutlet weak var uploadImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        getUserInfo()
        profileImage()
        
    }
    private func getUserInfo(){
        Network.getUserInfo(completion: { (result) in
        }) { (error) in
            self.makeAlert(textInput: "Ok", messageInput: error.localizedDescription)
        }
    }
    
    private func setupUI(){
        tweetButton.cornerRadius(radius: 10.0)
        pestTextInput.makeBorder(width: 0.5, color: .blue)
        pestTextInput.cornerRadius(radius: 8.0)
        uploadVCprofilePhoto.cornerRadius(radius: uploadVCprofilePhoto.frame.size.width/2)
    }
    
    @IBAction func backFeedVCButton(_ sender: UIButton) {
       dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func tweetButtonClicked(_ sender: UIButton) {
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        let mediaFolder = storageReferance.child("media")
        let text = self.pestTextInput.text
        if let data = self.uploadImageView.image?.jpegData(compressionQuality: 0.5){
              let uuid = UUID().uuidString
              let imageReferance = mediaFolder.child("\(uuid).jpg")
              imageReferance.putData(data, metadata: nil) { (metdata, error) in
                if error != nil {
                    self.makeAlert(textInput: "ERROR", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    imageReferance.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl = url?.absoluteString
                            self.uploadPostData(text: text, imageUrl: imageUrl)
                        }
                    }
                }
            }
        }else{
            uploadPostData(text: text)
        }
        
    }
    
    private func uploadPostData(text: String? = "", imageUrl: String? = ""){
        Network.uploadPost(text: text, imageUrl: imageUrl, completion: { (result) in
            if result{
                self.dismiss(animated: true, completion: nil)
            }
        }) { (error) in
            self.makeAlert(textInput: "ERROR", messageInput: error.localizedDescription)
        }
    }
    
    func profileImage(){
        Network.getUserInfo(completion: { (result) in
            if result{
                self.uploadVCprofilePhoto.sd_setImage(with: URL(string: UserInfo.sharedUserInfo.imageUrl))
            }
        }) { (error) in
            self.makeAlert(textInput: "ERROR", messageInput: error.localizedDescription)
        }
    }
    
    static func goUploadPost(from: UIViewController){
        
       if let uploadVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "UploadViewController") as? UploadViewController{
          from.present(uploadVC, animated: true, completion: nil)
       }
    }
    
}

extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          uploadImageView.image = info[.originalImage] as? UIImage
          self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectPhotoButton(_ sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
}
