//
//  ResponseDto.swift
//  PicScape
//
//  Created by Arthur Zerr on 19.12.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import Foundation

struct ResponseDto : Decodable{
    
    var message : String
    var show : Bool
    var success : Bool
    var data : String
}
