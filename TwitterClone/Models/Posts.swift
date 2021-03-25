//
//  Posts.swift
//  TwitterClone
//
//  Created by Asit Aslan on 4.03.2021.
//  Copyright © 2021 Asit Aslan. All rights reserved.
//

import Foundation

struct Posts: Codable{
    var date: Date
    var userNmae: String
    var name: String
    var postImageUrl: String
    var postText: String
    var profileImageUrl: String
}
