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
}
