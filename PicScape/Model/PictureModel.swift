//
//  Picture_Model.swift
//  PicScape
//
//  Created by Arthur Zerr on 17.11.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import Foundation
import SwiftUI

struct PictureModel:  Hashable, Codable, Identifiable {
    
    var id: Int
    var PicUrl: String
    var UserId: Int
  
    var featureImage: Image? {
           return Image(
               ImageStore.loadImage(name: "\(PicUrl)"),
               scale: 2,
               label: Text(verbatim: PicUrl))
    }
}

extension PictureModel {
    var image: Image {
        ImageStore.shared.image(name: PicUrl)
    }
}

