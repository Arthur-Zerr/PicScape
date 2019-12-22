//
//  UserForRegisterDto.swift
//  PicScape
//
//  Created by Arthur Zerr on 22.12.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import Foundation

struct UserForRegisterDto : Encodable{
    
    var Username : String = ""
    var Email : String = ""
    var Password: String = ""
    var ConfirmPassword: String = ""
    
}
