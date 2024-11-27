//
//  PostPresenter.swift
//  PostDemo
//
//  Created by Sunfocus Solutions on 26/11/24.
//

import UIKit

protocol PostPresenterProtocol: AnyObject {
    func didFetchPosts(_ posts: [Post])
    func didAddPost()
}

protocol PostViewProtocol: AnyObject {
    func displayPosts(_ posts: [Post])
}

class PostPresenter: PostPresenterProtocol {
    
    weak var view: PostViewProtocol?
    var interactor: PostInteractorProtocol?
    
    init(view: PostViewProtocol) {
        self.view = view
    }
    
    func fetchPost() {
        interactor?.fetchPost()
    }
    
    func addPost(id: Int, userName: String, postText: String, postImage: UIImage) {
        interactor?.addPost(id: id, userName: userName, postText: postText, postImage: postImage)
    }
    
    func didFetchPosts(_ posts: [Post]) {
        view?.displayPosts(posts)
    }
    
    func didAddPost() {
        interactor?.fetchPost()
    }
}
