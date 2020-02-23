//
//  Picture_Component.swift
//  PicScape
//
//  Created by Arthur Zerr on 26.09.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI
import CoreLocation

struct PictureComponent: View {
    var pictureData: PictureComponentModel
    var ShowInfo : Bool
    var body: some View {
        VStack{
            if ShowInfo == true{
                HStack(alignment: .center){
                    VStack(alignment: .leading){
                        Text(pictureData.Title).font(.headline)
                        Text(pictureData.UserName).font(.caption)
                    }
                    Spacer()
                    Button(action: {self.ShowMap()}){
                        Image("Map_icon")
                            .resizable()
                            .frame(width: 32, height:32)
                    }
                }
            }
        }
    }
    func ShowMap() {
        
    }
}

struct PictureComponentPreviews: PreviewProvider {
    static var previews: some View {
        PictureComponent(pictureData : PictureComponentModel(id: 0, PicUrl: "", Title: "", Cor_X: 0, Cor_Y: 0, UserId: 0, UserName: ""),ShowInfo: true)
    }
}
