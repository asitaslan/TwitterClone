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
    static var postArray = [GetPost]()
   
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
    
    static func getPostInfo(compliton: @escaping (_ isSuccess: Bool) ->(), fail: @escaping (Error) -> ()){
        
        firestoreDatabase.collection("SharedPost").order(by: "date", descending: true).getDocuments { (snapshots, error) in
            if error != nil{
                fail(error!)
            }else{
                if snapshots?.isEmpty != true && snapshots != nil {
                    postArray.removeAll(keepingCapacity: false)
                    for document in snapshots!.documents{
                        if let username = document.get("userNmae") as? String{
                            Posts.postsInfo.userNmae = username
                        }
                        if let imageUrl = document.get("imageUrl") as? String{
                            Posts.postsInfo.postImageUrl = imageUrl
                        }
                        if let postsText = document.get("postText") as? String{
                            Posts.postsInfo.postText = postsText
                        }
                        if let profileImage = document.get("profileImageUrl") as? String{
                            Posts.postsInfo.profileImageUrl = profileImage
                        }
                        if let name = document.get("name") as? String{
                            Posts.postsInfo.name = name
                        }
                        let post = GetPost.init(userNmae: Posts.postsInfo.userNmae,
                                                name: Posts.postsInfo.name,
                                                postImageUrl: Posts.postsInfo.postImageUrl,
                                                postText: Posts.postsInfo.postText,
                                                profileImageUrl: Posts.postsInfo.profileImageUrl)
                        postArray.append(post)
                    }
                }
                compliton(true)
            }
        }
    }
    
    static func updateUser(name: String? = "", userNmae: String? = "", profileImage: String? = "", backImage: String? = "",
                           complition: @escaping (_ isSuccess: Bool) ->(), fail: @escaping (Error) ->()){
        
    firestoreDatabase.collection("UserInfo").whereField("email", isEqualTo: Auth.auth().currentUser!.email!).getDocuments { (snaphot, error) in
            if error != nil{
                fail(error!)
            }else{
                if snaphot?.isEmpty != true && snaphot != nil{
                    if let name = name{
                        if name != ""{
                            let document = snaphot!.documents.first?.reference.updateData(["name" : name])
                        }
                    }
                    if let username = userNmae{
                        if username != ""{
                            let document = snaphot?.documents.first?.reference.updateData(["userNmae": username])
                        }
                        
                    }
                    if let imageUrl = profileImage{
                        if imageUrl != "" {
                            let document = snaphot?.documents.first?.reference.updateData(["imageUrl" : imageUrl])
                        }
                    }
                }
            }
        }
    }
}
    

