//
//  User.swift
//  PicScape
//
//  Created by Arthur Zerr on 26.09.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import Foundation
import SwiftUI

struct User: Codable, Hashable{
    
    var Id: String
    var Username: String
    
    //var UserPicUrl: String
    
    var Firstname: String
    var LastName: String
    
    var City: String
    var Country: String
    
}
