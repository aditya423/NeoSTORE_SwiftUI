//
//  Neostore_SwiftUIApp.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 11/01/24.
//

import SwiftUI

@main
struct Neostore_SwiftUIApp: App {
    @Environment(\.scenePhase) var scenePhase
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                HomeView()
            } else {
                LoginView()
            }
        }.onChange(of: scenePhase) { _ in
            // Handle scene changes here
        }
    }
}
