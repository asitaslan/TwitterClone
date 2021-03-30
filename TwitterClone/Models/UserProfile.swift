//
//  UserProfile.swift
//  TwitterClone
//
//  Created by Asit Aslan on 4.03.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import Foundation

class UserInfo {
    
    static let sharedUserInfo = UserInfo()
    
    var userName = ""
    var Name = ""
    var email = ""
    var password = ""
    var imageUrl = ""
    var backImageUrl = ""
    
    private init(){
        
    }
}
