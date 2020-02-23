//
//  ImagePicker.swift
//  PicScape
//
//  Created by Arthur Zerr on 17.11.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var isVisibile:Bool
    @Binding var image:UIImage?
    var sourceType:Int
    
    func makeCoordinator() -> Coordinator {
        Coordinator(isVisibile: $isVisibile, image: $image)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let vc = UIImagePickerController()
        vc.allowsEditing = true
        vc.sourceType = sourceType == 1 ? .photoLibrary : .camera
        
        vc.delegate = context.coordinator
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        @Binding var isVisibile:Bool
        @Binding var image:UIImage?
        
        init(isVisibile: Binding<Bool>, image: Binding<UIImage?>) {
            _isVisibile = isVisibile
            _image = image
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiimage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            image = uiimage
            isVisibile = false
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isVisibile = false
        }
    }
}

