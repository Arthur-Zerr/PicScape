//
//  PictureRowComponent.swift
//  PicScape
//
//  Created by Arthur Zerr on 10.03.20.
//  Copyright © 2020 ArthurZerr. All rights reserved.
//

import SwiftUI

struct PictureRowComponent: View {
    
    var pictureRow : [PictureListModel]

    @EnvironmentObject private var errorData : ErrorBinding
    @EnvironmentObject private var loadingData : LoadingBinding
    
    @State var showBigPicture : Bool = false
    @State var selectedPictureid : Int = 0
    @State var selectedPictureImage : UIImage = UIImage(named: "User_icon")!
    
    var body: some View {
        HStack(alignment: .center) {
            ForEach(pictureRow) { cell in
                Image(uiImage: cell.image)
                    .resizable().padding(EdgeInsets.init(top: -5, leading: -3, bottom: -5, trailing: -3)).aspectRatio(4/3, contentMode: .fit)
                    .onTapGesture {
                        self.selectedPictureid = cell.id
                        self.selectedPictureImage = cell.image
                        self.showBigPicture = true
                }
            }
        }.sheet(isPresented: self.$showBigPicture){
            SinglePictureView(image : self.selectedPictureImage, id : self.selectedPictureid)
                .onDisappear(){
                    self.showBigPicture = false
            }
            .environmentObject(self.errorData)
            .environmentObject(self.loadingData)

        }
    }
}

struct PictureRowComponent_Previews: PreviewProvider {
    static var previews: some View {
        PictureRowComponent(pictureRow: [PictureListModel(id: 0, image: UIImage(named: "User_icon")!)])
        .environmentObject(ErrorBinding())
        .environmentObject(LoadingBinding())
    }
}
