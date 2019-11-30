//
//  Picture_Component.swift
//  PicScape
//
//  Created by Arthur Zerr on 26.09.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI
import CoreLocation

struct Picture_Component: View {
    var pictureData: Picture_Component_Model
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
            pictureData.featureImage?.resizable().aspectRatio(3 / 2, contentMode: .fit)
        }
    }
    
    func ShowMap() {
        
    }
}

struct Picture_Component_Previews: PreviewProvider {
    static var previews: some View {
        Picture_Component(pictureData: PicScapeData[1], ShowInfo: true)
    }
}
