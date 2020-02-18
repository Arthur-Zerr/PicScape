//
//  Picture_Component_Model.swift
//  PicScape
//
//  Created by Arthur Zerr on 26.09.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftUI

struct PictureComponentModel: Hashable, Codable, Identifiable {
    
    var id: Int
    var PicUrl: String
    var Title: String
    
    //Location data to Show on Map
    var Cor_X: Double
    var Cor_Y: Double
    
    //Basic User Info
    var UserId: Int
    var UserName: String
}

extension PictureComponentModel {
    var image: Image {
        ImageStore.shared.image(name: PicUrl)
    }
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: Cor_Y,
            longitude: Cor_X)
    }
    var featureImage: Image? {
           return Image(
               ImageStore.loadImage(name: "\(PicUrl)"),
               scale: 2,
               label: Text(verbatim: Title))
       }
}
