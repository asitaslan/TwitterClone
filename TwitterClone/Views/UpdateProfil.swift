//
//  UpdateProfil.swift
//  TwitterClone
//
//  Created by Asit Aslan on 28.03.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit
import Firebase
import SDWebImage
class UpdateProfil: BaseViewController {

    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameTextInput: UITextField!
    @IBOutlet weak var userNameInput: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    var imageUrl: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        imageGesture()
        viewWillAppear(true)
        backImageGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bringUserInfo()
    }
    
    func setupUI(){
        updateButton.cornerRadius(radius: 8.0)
        profileImage.cornerRadius(radius: profileImage.frame.size.width/2)
    }
    
    func bringUserInfo(){
        Network.getUserInfo(completion: { (result) in
            self.nameTextInput.text = UserInfo.sharedUserInfo.Name
            self.profileImage.sd_setImage(with: URL(string: UserInfo.sharedUserInfo.imageUrl))
            self.userNameInput.text = UserInfo.sharedUserInfo.userName
            
        }) { (error) in
            
        }
    }
    
  
    @IBAction func updateButtonCliced(_ sender: UIButton) {
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        let mediaFolder = storageReferance.child("media")
        if let data = self.profileImage.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            imageReferance.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    self.makeAlert(textInput: "ERROR", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    imageReferance.downloadURL { (url, error) in
                        let imageurl = url?.absoluteString
                        self.imageUrl = imageurl
                        
                    }
                }
            }
            
        }else{
         
        }
        if let dataBackImage = self.backImage.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            imageReferance.putData(dataBackImage, metadata: nil){(metadata, error) in
                if error != nil {
                    self.makeAlert(textInput: "ERROR", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    imageReferance.downloadURL { (url, error) in
                        let backImageUrl = url?.absoluteString
                        Network.updateUser(name: self.nameTextInput.text,
                                           userNmae: self.userNameInput.text,
                                           profileImage: self.imageUrl,
                                           backImage: backImageUrl, complition: { (result) in
                            if result{
                                
                            }
                        }) { (error) in
                            self.makeAlert(textInput: "ERROR", messageInput: error.localizedDescription)
                        }
                    }
                }
            }
        }
        
    }
    
}
extension UpdateProfil: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
  
    func imageGesture(){
        profileImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePicture))
        profileImage.addGestureRecognizer(gestureRecognizer)
    }
    
    func backImageGesture(){
        backImage.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(choosePicture))
        backImage.addGestureRecognizer(gesture)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        profileImage.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func choosePicture(){

         let picker = UIImagePickerController()
         picker.delegate = self
         picker.sourceType = .photoLibrary
         self.present(picker, animated: true, completion: nil)
     }
}
