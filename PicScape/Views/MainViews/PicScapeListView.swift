//
//  PicScapeListView.swift
//  PicScape
//
//  Created by Arthur Zerr on 17.11.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI

struct PicScapeListView: View {
    
    @EnvironmentObject private var userData : UserBinding
    
    var body: some View {
        VStack{
            Text("In Development")
        }
    }
}

struct PicScapeListView_Previews: PreviewProvider {
    static var previews: some View {
        PicScapeListView()
            .environmentObject(UserBinding())
    }
}
