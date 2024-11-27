//
//  Extension+View.swift
//  PostDemo
//
//  Created by Sunfocus Solutions on 26/11/24.
//

import SwiftUI

extension View {
    func centered() -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .multilineTextAlignment(.center)
            .foregroundColor(.black)
    }
}

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
