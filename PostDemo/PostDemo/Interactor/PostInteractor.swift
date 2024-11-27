//
//  PostInteractor.swift
//  PostDemo
//
//  Created by Sunfocus Solutions on 26/11/24.
//

import UIKit

protocol PostInteractorProtocol: AnyObject {
    func fetchPost()
    func addPost(id: Int, userName: String, postText: String, postImage: UIImage)
}

class PostInteractor: PostInteractorProtocol {
    weak var presenter: PostPresenterProtocol?
    
    func fetchPost() {
        presenter?.didFetchPosts(posts)
    }
    
    func addPost(id: Int, userName: String, postText: String, postImage: UIImage) {
        let newPost = Post(id: id, userName: userName, postText: postText, postImage: postImage)
        posts.append(newPost)
        presenter?.didAddPost()
    }
}
