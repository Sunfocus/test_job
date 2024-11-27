//
//  Post.swift
//  PostDemo
//
//  Created by Sunfocus Solutions on 26/11/24.
//

import SwiftUI

struct Post {
    var id: Int
    var userName : String
    var userImage: UIImage
    var postText: String
    var postImage: UIImage
    
    init(id: Int, userName: String, userImage: UIImage = .profilePlaceholder, postText: String, postImage: UIImage) {
        self.id = id
        self.userName = userName
        self.userImage = userImage
        self.postText = postText
        self.postImage = postImage
    }
}
