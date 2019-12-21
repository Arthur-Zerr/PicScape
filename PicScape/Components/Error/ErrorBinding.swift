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
//    var hasErrorWillChange = PassthroughSubject<Void, Never>()
//    var MessageWillChange = PassthroughSubject<Void, Never>()
    
    @Published var hasError : Bool  = false //{ willSet { hasErrorWillChange.send() }}
    @Published var Message : String  = "" //{ willSet { MessageWillChange.send() }}
}
