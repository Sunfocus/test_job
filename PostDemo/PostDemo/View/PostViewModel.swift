//
//  PostViewModel.swift
//  PostDemo
//
//  Created by Sunfocus Solutions on 26/11/24.
//

import UIKit

var posts: [Post] = [] // We are using this variable beacuse we are storing it locally.

class PostViewModel: ObservableObject, PostViewProtocol {
    
    @Published var posts: [Post] = []
    @Published var id: Int = 0
    @Published var userName : String = ""
    @Published var postText: String = ""
    @Published var postImage: UIImage = UIImage()
    
    var presenter: PostPresenter?
    
    init() {
        self.presenter = PostPresenter(view: self)
        presenter?.fetchPost()
    }
    
    func displayPosts(_ posts: [Post]) {
        DispatchQueue.main.async {
            self.posts = posts
        }
    }

    func fetchPost() {
        presenter?.fetchPost()
    }
    

    func addPost(post: Post) {
        presenter?.addPost(id: post.id, userName: post.userName, postText: post.postText, postImage: post.postImage)
    }
}

