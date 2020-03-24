//
//  PictureDataDto.swift
//  PicScape
//
//  Created by Arthur Zerr on 12.03.20.
//  Copyright © 2020 ArthurZerr. All rights reserved.
//

import Foundation

struct PictureDataDto : Codable{
    var id : Int
    var userID : String
    var title : String
    var uploadDate : String
}
