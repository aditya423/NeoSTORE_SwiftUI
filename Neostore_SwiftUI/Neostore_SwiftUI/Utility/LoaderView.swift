//
//  LoaderView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 01/02/24.
//

import SwiftUI
//MARK: - Custom Loader
struct LoaderView: View {
    @State var bgColor: Color?
    @State var tintColor: Color?
    var body: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: tintColor ?? .red))
            .scaleEffect(1.2, anchor: .center)
            .padding(20)
            .background(bgColor)
            .cornerRadius(5)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
