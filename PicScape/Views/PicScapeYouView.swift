//
//  PicScapeYouView.swift
//  PicScape
//
//  Created by Arthur Zerr on 18.11.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct PicScapeYouView: View {
    @State var isOnline = false;
    @State var showImagePicker:Bool = false
    @State var showActionSheet:Bool = false
    @State var sourceType:Int = 0
    @State var image:Image?
    
    var user : User
    
    var body: some View {
        VStack{
           if !showImagePicker {
                VStack{
                    user.UserPicture?
                        .resizable()
                        .clipped()
                        .clipShape(Circle())
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 160, height: 160)

                    Text(user.Username)
                        .fontWeight(.bold)

                }
                VStack{
                    HStack{
                        Text(isOnline.description)
                        Button(action: {self.SendRequest()}){
                            Image("Refresh_icon")
                                .resizable()
                                .frame(width: 32, height:32)
                        }
                        if isOnline {
                        Circle().foregroundColor(Color.green)
                            .frame(width: 32, height:32)
                        }else {
                            Circle().foregroundColor(Color.red)
                            .frame(width: 32, height:32)
                        }
                        CameraButtonView(showActionSheet: $showActionSheet)
                    }
                    WaterfallGrid(PicScapeNewData) { picscapedata in
                        PicScapeNew_Component(pictureData: picscapedata)
                    }.gridStyle(columns: 3, spacing: 8)
                }
                .actionSheet(isPresented: $showActionSheet, content: { () -> ActionSheet in
                    ActionSheet(title: Text("Select Image"), message: Text("Please select an image from the image gallery or use the camera"), buttons: [
                        ActionSheet.Button.default(Text("Camera"), action: {
                            self.sourceType = 0
                            self.showImagePicker.toggle()
                        }),
                        ActionSheet.Button.default(Text("Photo Gallery"), action: {
                            self.sourceType = 1
                            self.showImagePicker.toggle()
                        }),
                        ActionSheet.Button.cancel()
                    ])
                })
                
            }
            if showImagePicker {
                ImagePicker(isVisibile: $showImagePicker, image: $image, sourceType: sourceType)
            }
        }
    }
    func SendRequest()
    {
        isOnline = PicScapeAPI.getIsOnline()
    }
}



struct PicScapeYouView_Previews: PreviewProvider {
    static var previews: some View {
        PicScapeYouView(user: User(id: 1, Username: "Arthur", UserPicUrl: "Arthur", FirstName: "Arthur", LastName: "Zerr", City: "", Country: ""))
    }
}
