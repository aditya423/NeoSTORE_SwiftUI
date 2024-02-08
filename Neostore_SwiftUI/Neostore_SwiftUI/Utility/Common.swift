//
//  LoaderView.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 01/02/24.
//

import SwiftUI

// LOADER
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

// SAVE IMAGE
func saveImage(imageData: Data) {
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileName = ImageNames.profileImage.rawValue
    let fileURL = documentsDirectory.appendingPathComponent(fileName)
    
    do {
        try imageData.write(to: fileURL)
        print("Profile picture saved to local storage at \(fileURL.path)")
    } catch {
        print("Error saving profile picture: \(error.localizedDescription)")
    }
}

// LOAD IMAGE
func loadImage(imgName: String) -> Image? {
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let fileURL = documentsDirectory.appendingPathComponent(imgName)
    
    if FileManager.default.fileExists(atPath: fileURL.path) {
        if let imageData = try? Data(contentsOf: fileURL) {
            if let uiImage = UIImage(data: imageData) {
                return Image(uiImage: uiImage)
            }
        }
    }
    return nil
}
