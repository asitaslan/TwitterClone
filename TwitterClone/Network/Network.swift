//
//  Network.swift
//  TwitterClone
//
//  Created by Asit Aslan on 23.03.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import Foundation
import Firebase
class Network {
    static var firestoreDatabase = Firestore.firestore()
    
    static func getUserInfo(completion: @escaping (_ isSuccess: Bool) ->(), fail: @escaping (Error) ->()){
        
        firestoreDatabase.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { (snapshot, error) in
            if  let error = error {
                fail(error)
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
                    completion(true)
                }
            }
         }
    }
    
    static func uploadPost(text: String? = "", imageUrl: String? = "", completion: @escaping (_ isSuccess: Bool) ->(), fail: @escaping (Error) ->()){
        let firestore = Firestore.firestore()
        var userDictonary: [String: Any] = [:]
        if (imageUrl != "" && text != "") {
            userDictonary = ["profileImageUrl": UserInfo.sharedUserInfo.imageUrl,
                             "userNmae": UserInfo.sharedUserInfo.userName,
                             "name": UserInfo.sharedUserInfo.Name,
                             "postText": text!,
                             "date":FieldValue.serverTimestamp(),
                             "imageUrl": imageUrl!]
            
        }else if imageUrl != "" && text == "" {
            userDictonary = ["profileImageUrl": UserInfo.sharedUserInfo.imageUrl,
                             "userNmae": UserInfo.sharedUserInfo.userName,
                             "name": UserInfo.sharedUserInfo.Name,
                             "date":FieldValue.serverTimestamp(),
                             "postText": "",
                             "imageUrl": imageUrl!]
            
        }else if imageUrl == "" && text != "" {
            userDictonary = ["profileImageUrl": UserInfo.sharedUserInfo.imageUrl,
                             "userNmae": UserInfo.sharedUserInfo.userName,
                             "name": UserInfo.sharedUserInfo.Name,
                             "postText": text!,
                             "date":FieldValue.serverTimestamp(),
                             "imageUrl": ""]
        }
        firestore.collection("SharedPost").addDocument(data: userDictonary as [String : Any]) { (error) in
            if let error = error{
                fail(error)
            }else{
                completion(true)
           }
        }
    }
    
    static func getPostInfo(url: URL, compliton: @escaping (Posts) ->(), fail: @escaping (Error) -> ()){
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error{
                fail(error)
            }else if let data = data{
                let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                print(json ?? "")
            }
        }
    }
    
}
    

