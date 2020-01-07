//
//  ErrorBinding.swift
//  PicScape
//
//  Created by Arthur Zerr on 21.12.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI
import Combine

class ErrorBinding: ObservableObject {
    @Published var hasError : Bool  = false
    @Published var Message : String  = ""
}
