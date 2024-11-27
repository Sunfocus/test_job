//
//  PostDemoApp.swift
//  PostDemo
//
//  Created by Sunfocus Solutions on 26/11/24.
//

import SwiftUI

@main
struct PostDemoApp: App {
    @StateObject var router = Router()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                switch router.root {
                case .onboarding:
                    SplashView()
                        .navigationDestination(for: Router.OnboardingDestination.self) { destination in
                            router.destination(for: destination)
                        }
                case .settings:
                    SplashView()
                        .navigationDestination(for: Router.OnboardingDestination.self) { destination in
                            router.destination(for: destination)
                        }
                }
            }
            .environmentObject(router)
        }
    }
}
