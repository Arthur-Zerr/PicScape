//
//  UserBinding.swift
//  PicScape
//
//  Created by Arthur Zerr on 22.12.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI
import Combine

class UserBinding: ObservableObject {
    @Published var UserData : User = User(Id: "", Username: "", Firstname: "", LastName: "", City: "", Country: "")
    @Published var UserPicture : Image? = Image("User_icon")
}
