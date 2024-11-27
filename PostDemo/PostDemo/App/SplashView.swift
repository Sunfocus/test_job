//
//  ContentView.swift
//  PostDemo
//
//  Created by Sunfocus Solutions on 26/11/24.
//

import SwiftUI

struct SplashView: View {
    // MARK: - Variable (To Show Launch Screen)
    @State var isAppActive: Bool = false
    
    @State private var displayedText: String = "" // State to hold the visible text
    private let fullText = "Welcome"
    
    var body: some View {
        VStack {
            if isAppActive {
                Router.createModule()
            }else {
                // Set the Launch Screen with typing animation
                Text(displayedText)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .onAppear {
                        typeText()
                    }
            }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                withAnimation {
                    isAppActive = true
                }
            }
        }
    }
    
    // Function to simulate typing effect
    func typeText() {
        var characterIndex = 0
        displayedText = ""
        
        // Timer to reveal one character at a time
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if characterIndex < fullText.count {
                displayedText += String(fullText[fullText.index(fullText.startIndex, offsetBy: characterIndex)])
                characterIndex += 1
            } else {
                timer.invalidate() // Stop timer once all characters are revealed
            }
        }
    }
}

#Preview {
    SplashView()
}
