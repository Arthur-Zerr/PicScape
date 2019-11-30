//
//  User.swift
//  PicScape
//
//  Created by Arthur Zerr on 26.09.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import Foundation
import SwiftUI

struct User: Hashable, Codable, Identifiable {
    
    var id: Int
    var Username: String
    
    var UserPicUrl: String
    
    var FirstName: String
    var LastName: String
    
    var City: String
    var Country: String
    
    var UserPicture : Image? {
        return Image(
            ImageStore.loadImage(name: "\(UserPicUrl)"),
            scale: 2,
            label: Text(verbatim: UserPicUrl))
    }
}
