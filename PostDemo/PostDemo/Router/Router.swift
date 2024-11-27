//
//  Router.swift
//  PostDemo
//
//  Created by Sunfocus Solutions on 26/11/24.
//

import Foundation
import SwiftUI

protocol PostRouterProtocol: AnyObject {
    associatedtype ContentView: View
    static func createModule() -> ContentView
}

final class Router: ObservableObject, PostRouterProtocol {
    
    public enum OnboardingDestination: Codable, Hashable {
        case createPost(user: User)
        case postListing
    }
    
    enum RootFlow{
        case onboarding
        case settings
    }
    
    var root: RootFlow = .onboarding
    
    @Published var navPath = NavigationPath()
    private var destinations: [OnboardingDestination] = []
   
    func navigate(to destination: OnboardingDestination) {
        navPath.append(destination)
        destinations.append(destination)
    }
  
    func navigateBack() {
        navPath.removeLast()
        destinations.removeLast()
    }
   
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
        destinations.removeAll()
    }
  
    private func indexOf(destination: OnboardingDestination) -> Int? {
        return destinations.firstIndex(of: destination)
    }
   
    func navigateBack(to destination: OnboardingDestination) {
        if let index = destinations.firstIndex(of: destination) {
            navPath = NavigationPath()
            for i in 0...index {
                navPath.append(destinations[i])
            }
        }
    }
    
    func setRoot(root: RootFlow){
        self.root = root
        navigateToRoot()
    }
    
    static func createModule() -> some View {
        let viewModel = PostViewModel() // Conforms to PostViewProtocol
        let interactor = PostInteractor() // Conforms to PostInteractorProtocol
        let presenter = PostPresenter(view: viewModel) // Inject ViewModel into Presenter
        
        // Establish VIPER connections
        presenter.interactor = interactor
        interactor.presenter = presenter
        viewModel.presenter = presenter
        
        // Return the View
        return PostView(viewModel: viewModel)
    }
    
    static func createPostView(for user: User) -> some View {
        // Initialize VIPER components
        let viewModel = PostViewModel() // Conforms to PostViewProtocol
        let interactor = PostInteractor() // Conforms to PostInteractorProtocol
        let presenter = PostPresenter(view: viewModel) // Inject ViewModel into Presenter
        
        // Establish VIPER connections
        presenter.interactor = interactor
        viewModel.presenter = presenter
        interactor.presenter = presenter
        
        // Return the CreatePostView with the injected user and viewModel
        return CreatePostView(user: user, viewModel: viewModel)
    }


}

extension Router{
    @ViewBuilder
    func destination(for flow: OnboardingDestination) -> some View{
        switch flow{
        case .createPost(let user):
            Router.createPostView(for: user)
        case .postListing:
            Router.createModule()
        }
    }
}
