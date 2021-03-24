//
//  SignUpVC.swift
//  TwitterClone
//
//  Created by Asit Aslan on 24.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit
import Firebase
class SignUpVC: BaseViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameSurnameTxt: UITextField!
    @IBOutlet weak var emailTx: UITextField!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    var choseenImageUrl: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        imageGesture()
    }
    
    func setupUI(){
        profileImage.cornerRadius(radius: profileImage.frame.size.width/2)
        signUpButton.cornerRadius(radius: 8.0)
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
        if nameSurnameTxt.text != "" && emailTx.text != "" && userNameText.text != "" && passwordText.text != ""{
            Auth.auth().createUser(withEmail: emailTx.text!, password: passwordText.text!) { (auth, error) in
                if error != nil {
                      self.makeAlert(textInput: "ERROR", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    let storage = Storage.storage()
                    let storageReferance = storage.reference()
                    let mediaFolder = storageReferance.child("media")
                        
                    if let data = self.profileImage.image?.jpegData(compressionQuality: 0.5){
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
                                        let userDictonary = ["email": self.emailTx.text!,
                                                             "userNmae":self.userNameText.text!,
                                                             "name": self.nameSurnameTxt.text!,
                                                             "password": self.passwordText.text!,
                                                             "imageUrl": imageUrl]
                                        
                                        firestore.collection("UserInfo").addDocument(data: userDictonary as [String : Any]) { (error) in
                                            if error != nil{
                                                self.makeAlert(textInput: "ERROR", messageInput: error?.localizedDescription ?? "error")
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    self.dismiss(animated: true, completion: nil)
                }
           }
        }
    }
}

extension SignUpVC: UIImagePickerControllerDelegate , UINavigationControllerDelegate{
  
    func imageGesture(){
        profileImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choosePicture))
        profileImage.addGestureRecognizer(gestureRecognizer)
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
