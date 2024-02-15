//
//  PhotoPicker.swift
//  Neostore_SwiftUI
//
//  Created by webwerks  on 15/02/24.
//

import Foundation
import SwiftUI
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var pickerResult: [UIImage] // pass images back to the SwiftUI view
    @Binding var isPresented: Bool // close the modal view
    
    func makeUIViewController(context: Context) -> some UIViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images // filter only to images
        configuration.selectionLimit = 1 // ignore limit
        
        let photoPickerViewController = PHPickerViewController(configuration: configuration)
        photoPickerViewController.delegate = context.coordinator // Use Coordinator for delegation
        return photoPickerViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // Create the Coordinator, in this case it is a way to communicate with the PHPickerViewController
    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.pickerResult.removeAll() // remove previous pictures from the main view
            
            results.forEach { result in
                result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                    guard let image = reading as? UIImage, error == nil else { return }
                    DispatchQueue.main.async {
                        self.parent.pickerResult = [image]
                    }
                }
            }
            
            parent.isPresented = false
        }
    }
}
