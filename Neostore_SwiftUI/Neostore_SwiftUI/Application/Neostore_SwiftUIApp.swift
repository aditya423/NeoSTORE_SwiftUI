//
//  Neostore_SwiftUIApp.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 11/01/24.
//

import SwiftUI

@main
struct Neostore_SwiftUIApp: App {

    @State private var navigationId = UUID()
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                if UserDefaults.standard.isLoggedIn() {
                    HomeView()
                } else {
                    LoginView()
                }
            }
            .environmentObject(LocationSearchViewModel())
            .id(navigationId)
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("popToLogin"))) { _ in
                navigationId = UUID()
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name(NotificationNames.popToHome.rawValue))) { _ in
                navigationId = UUID()
            }
        }
    }
}
