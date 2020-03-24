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
    var id : Int
    var userID : String
    var img : String
}

