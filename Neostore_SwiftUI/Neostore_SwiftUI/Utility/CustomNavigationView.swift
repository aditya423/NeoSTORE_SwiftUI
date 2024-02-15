//
//  CustomNavigationView.swift
//  Neostore_SwiftUI
//
//  Created by Neosoft on 15/02/24.
//
import SwiftUI

struct CustomNavigationView<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        Group {
            if #available(iOS 16, *) {
                NavigationStack(root: content)
            } else {
                NavigationView {
                    content()
                }
            }
        }
    }
}
