//
//  LoginBinding.swift
//  PicScape
//
//  Created by Arthur Zerr on 21.12.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI
import Combine

class LoginBinding: ObservableObject {
    @Published var Username : String = ""
    @Published var Password : String = ""
    @Published var hasLogin : Bool = false
    @Published var loginMode : Bool = true
}
