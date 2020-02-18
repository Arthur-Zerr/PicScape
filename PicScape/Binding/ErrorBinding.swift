//
//  ErrorBinding.swift
//  PicScape
//
//  Created by Arthur Zerr on 21.12.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI
import Combine

//TODO change to MessageboxBinding or something like it 

class ErrorBinding: ObservableObject {
    @Published var hasError : Bool  = false
    @Published var Message : String  = ""
    @Published var Title : String  = ""
    
    func ShowError(message : String) {
        print("Error: " + message)
        Message = message
        Title = "Error"
        hasError = true
    }
    
    func ShowInformation(message : String) {
        print("Information: " + message)
        Message = message
        Title = "Information"
        hasError = true
    }
}
