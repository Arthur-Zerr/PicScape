//
//  LoadingBinding.swift
//  PicScape
//
//  Created by Arthur Zerr on 21.12.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI
import Combine

class LoadingBinding: ObservableObject {
    @Published var Loading : Bool = false
    
    var LoadingNumber : Int = 0
    
    func Show(){
        LoadingNumber += 1
        Loading = true
    }
    
    func Close(){
        LoadingNumber -= 1
        if LoadingNumber <= 1{
            Loading = false
        }
    }
}
