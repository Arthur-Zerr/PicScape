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
            userData.UserPicture?
                .resizable()
                .clipShape(Circle())
                .overlay(Circle().stroke(Color("InvertColor"), lineWidth: 4))
                .aspectRatio(contentMode: .fill)
                .frame(width: 75, height: 75)
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
