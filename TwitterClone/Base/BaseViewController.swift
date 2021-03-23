//
//  BaseViewController.swift
//  TwitterClone
//
//  Created by Asit Aslan on 28.02.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import UIKit
import Firebase
class BaseViewController: UIViewController {

    let firestoreDatabase = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func makeAlert(textInput:String,messageInput:String){
           let alert = UIAlertController(title: textInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
           let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
           alert.addAction(okButton)
           self.present(alert, animated: true, completion: nil)
    }
    
    func goUploadPost(){
       let uploadVC = self.storyboard?.instantiateViewController(withIdentifier: "toUploadVC") as! UploadViewController
       self.present(uploadVC, animated: true, completion: nil)
    }
    
    func getUserInfo(){
        
        firestoreDatabase.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { (snapshot, error) in
            if error != nil {
                self.makeAlert(textInput: "ERROR", messageInput: error?.localizedDescription ?? "ERROR")
            }else {
                
                if snapshot?.isEmpty == false && snapshot != nil {
                    for document in snapshot!.documents {
                        
                        if let username = document.get("userNmae") as? String {
                            UserInfo.sharedUserInfo.email = Auth.auth().currentUser!.email!
                            UserInfo.sharedUserInfo.userName = username
                         }
                        if let name = document.get("name") as? String {
                            UserInfo.sharedUserInfo.Name = name
                        }
                        if let imageUrl = document.get("imageUrl") as? String {
                            UserInfo.sharedUserInfo.imageUrl = imageUrl
                        }
                    
                     }
                }
            }
         }
    }
}

