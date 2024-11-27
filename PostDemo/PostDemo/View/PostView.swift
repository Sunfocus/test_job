//
//  PostView.swift
//  PostDemo
//
//  Created by Sunfocus Solutions on 26/11/24.
//

import SwiftUI

struct User: Codable, Hashable {
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}



struct PostView: View {
    @EnvironmentObject var router: Router
    
    @StateObject var viewModel = PostViewModel()

    let userList: [User] = [User(id: 1, name: "John"), User(id: 2, name: "David"), User(id: 3, name: "Ralph")]

        
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.posts.isEmpty{
                    emptyView()
                } else {
                    postsList()
                }
            }.navigationTitle("Posts")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            ForEach(userList, id: \.id) { user in
                                Button(action: {
                                    router.navigate(to: .createPost(user: user))
                                }) {
                                    Text(user.name)
                                }
                            }
                        } label: {
                            Text("Create Post")
                                .font(.headline)
                                .padding(10)
                                .foregroundStyle(.white)
                                 .background(.green)
                                .clipShape(Capsule())
                        }
                    }
                }
                .onAppear {
                    viewModel.fetchPost()
                }
        }
    }
    
    // MARK: - In case no post available
    private func emptyView() -> some View {
        VStack {
            Image(.noData)
            Text("Please create a post")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .centered()
    }
    
    // MARK: - Create Post List
    private func postsList() -> some View {
        List {
            ForEach(viewModel.posts, id: \.id) { post in
                HStack(alignment: .top, spacing: 10) {
                    // MARK: - User Image
                    Image(uiImage: post.userImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())

                    // MARK: - User Name and Post Data
                    VStack(alignment: .leading, spacing: 5) {
                        // MARK: - User Name
                        Text(post.userName)
                            .font(.headline)
                            .fontWeight(.bold)

                        // MARK: - Post Text
                        Text(post.postText)
                            .font(.subheadline)
                            .foregroundColor(.black)

                        // MARK: - Post Image
                        GeometryReader { geometry in
                            Image(uiImage: post.postImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: geometry.size.width, height: 150)
                        }
                        .frame(height: 150)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.top, 20)
                    }
                }
                .padding(.vertical, 10)
            }
        }
    }
}

#Preview {
//    PostView()
    Router.createModule()
}
