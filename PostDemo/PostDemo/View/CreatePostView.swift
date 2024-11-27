//
//  CreatePostView.swift
//  PostDemo
//
//  Created by Sunfocus Solutions on 26/11/24.
//

import SwiftUI

struct CreatePostView: View {
    @EnvironmentObject var router: Router
    @State private var showMediaSelectionActionSheet: Bool = false
    @State private var selectedImage: UIImage?
    @State private var isShowingImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var postText: String = ""
    
    var user: User
    @ObservedObject var viewModel: PostViewModel

    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        Text("Create Post")
                            .font(.headline)
                        Spacer()
                    }
                    // MARK: - Select Post Image
                    VStack {
                        Group {
                            if let image = selectedImage {
                                Image(uiImage: image)
                                    .resizable()
                            }else {
                                Image(.placehoder)
                                    .resizable()
                            }
                        }
                        .frame(width: 180, height: 180)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .onTapGesture {
                            showMediaSelectionActionSheet = true
                        }
                        .actionSheet(isPresented: $showMediaSelectionActionSheet) {
                            ProfilePhotoSelectionSheet()
                        }
                        .sheet(isPresented: $isShowingImagePicker) {
                            ImagePickerSwiftUI(selectedImage: $selectedImage, sourceType: sourceType, allowsEditing: true)
                        }
                    }.padding(.top, 20)
                    // MARK: - Post TextField
                    TextField("What's on your mind?", text: $postText, axis: .vertical)
                        .lineLimit(4, reservesSpace: true)
                        .textFieldStyle(.plain)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.top, 50)
                        .padding(.horizontal, 30)
                    
                    // MARK: - Submit Button
                    Button(action: {
                        let newPost = Post(id: user.id, userName: user.name, postText: postText, postImage: selectedImage ?? UIImage())
                        viewModel.addPost(post: newPost)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            router.navigateBack()
                        }
                    }, label: {
                        Text("Submit")
                            .font(.headline)
                            .foregroundStyle(.white)
                            .frame(width: 250, height: 50)
                            .background(.black)
                            .clipShape(Capsule())
                    })
                    .padding(.top, 40)
                    Spacer()
                }.padding(.top, 40)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                BackButton()
            }
        }
        .onTapGesture {
            UIApplication.shared.dismissKeyboard()
        }
    }
    
    
    // MARK: - Profile Photo Selection Sheet
    fileprivate func ProfilePhotoSelectionSheet() -> ActionSheet {
        return ActionSheet(
            title: Text("Select Option"),
            message: Text(""),
            buttons: [
                .default(Text("Choose from Library")) {
                    sourceType = .photoLibrary
                    isShowingImagePicker = true
                },
                .default(Text("Take photo")) {
                    sourceType = .camera
                    isShowingImagePicker = true
                },
                .cancel()
            ]
        )
    }
}




struct BackButton: View {
    @EnvironmentObject var router: Router
    var action: (() -> Void)?
    var body: some View {
        Image(.arrowBackward)
            .resizable()
            .frame(width: 26 , height: 26)
            .onTapGesture {
                router.navigateBack()
            }
            .padding(.leading, 1)
    }
}
