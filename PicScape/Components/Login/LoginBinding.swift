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
//    var UsernameWillChange = PassthroughSubject<Void, Never>()
//    var PasswordWillChange = PassthroughSubject<Void, Never>()
//    var hasLoginWillChange = PassthroughSubject<Void, Never>()
    
    @Published var Username : String = "" //{ willSet { UsernameWillChange.send() }}
    @Published var Password : String = "" //{ willSet { PasswordWillChange.send() }}
    @Published var hasLogin : Bool = false //{ willSet { hasLoginWillChange.send() }}
}
