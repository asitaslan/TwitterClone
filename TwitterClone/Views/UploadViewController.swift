//
//  UploadViewController.swift
//  TwitterClone
//
//  Created by Asit Aslan on 28.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit
import Firebase

class UploadViewController: BaseViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var pestTextInput: UITextView!
    @IBOutlet weak var uploadVCprofilePhoto: UIImageView!
    @IBOutlet weak var uploadImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cornerRadius()
    }
    
    func cornerRadius(){
        tweetButton.layer.cornerRadius = 10.0
        tweetButton.clipsToBounds = true
    }
    
    @IBAction func backFeedVCButton(_ sender: UIButton) {
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "toTabBarVC") as! UITabBarController
        self.present(homeVC, animated: true, completion: nil)
        
    }
    
    @IBAction func tweetButtonClicked(_ sender: UIButton) {
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        let mediaFolder = storageReferance.child("media")
            
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
                            let firestore = Firestore.firestore()
                            if (imageUrl != "" && self.pestTextInput.text != ""){
                                let userDictonary = ["profileImageUrl": UserInfo.sharedUserInfo.imageUrl, "userNmae": UserInfo.sharedUserInfo.userName, "name": UserInfo.sharedUserInfo.Name, "postText": self.pestTextInput!, "date":FieldValue.serverTimestamp(), "imageUrl": imageUrl!] as [String : Any]
                                firestore.collection("SharedPost").addDocument(data: userDictonary as [String : Any]) { (error) in
                                        if error != nil{
                                            self.makeAlert(textInput: "ERROR", messageInput: error?.localizedDescription ?? "error")
                                        }
                                }
                                self.backFeedVCButton(self.tweetButton)
                            }else if imageUrl != ""{
                                let userDictonary = ["profileImageUrl": UserInfo.sharedUserInfo.imageUrl, "userNmae": UserInfo.sharedUserInfo.userName, "name": UserInfo.sharedUserInfo.Name,  "date":FieldValue.serverTimestamp(), "imageUrl": imageUrl!] as [String : Any]
                                 firestore.collection("SharedPost").addDocument(data: userDictonary as [String : Any]) { (error) in
                                    if error != nil{
                                              self.makeAlert(textInput: "ERROR", messageInput: error?.localizedDescription ?? "error")
                                    }
                                 }
                                self.backFeedVCButton(self.tweetButton)
                            }else if self.pestTextInput.text != "" {
                                let userDictonary = ["profileImageUrl": UserInfo.sharedUserInfo.imageUrl, "userNmae": UserInfo.sharedUserInfo.userName, "name": UserInfo.sharedUserInfo.Name,  "date":FieldValue.serverTimestamp(), "postText": self.pestTextInput!] as [String : Any]
                                firestore.collection("SharedPost").addDocument(data: userDictonary as [String : Any]) { (error) in
                                    if error != nil{
                                        self.makeAlert(textInput: "ERROR", messageInput: error?.localizedDescription ?? "error")
                                    }
                                }
                                self.backFeedVCButton(self.tweetButton)
                            }else{
                                self.makeAlert(textInput: "OK", messageInput: "Please check your post! You can not post empty")
                            }
                        }
                    }
                }
            }
        }
        
    }
    
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
