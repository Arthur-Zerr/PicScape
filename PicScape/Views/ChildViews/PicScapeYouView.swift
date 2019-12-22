//
//  PicScapeYouView.swift
//  PicScape
//
//  Created by Arthur Zerr on 18.11.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI
import WaterfallGrid
import MapKit

struct PicScapeYouView: View {
    @State var showImagePicker:Bool = false
    @State var showActionSheet:Bool = false
    @State var sourceType:Int = 0
    @State var image:Image?
    
    @EnvironmentObject private var userData : UserBinding
    @EnvironmentObject private var loginData : LoginBinding
    
    var body: some View {
        VStack{
            if !showImagePicker {
                VStack{
                    userData.UserData.UserPicture?
                        .resizable()
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.white, lineWidth: 4))
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 80, height: 80)
                    
                    Text(userData.UserData.Username)
                        .fontWeight(.bold)
                    
                }
                VStack{
                    HStack{
                        CameraButtonView(showActionSheet: $showActionSheet)
                        Button("logout", action: UserLogout).padding()
                    }
                    MapView(coordinate: CLLocationCoordinate2D(
                        latitude: 1,
                        longitude: 1))
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
//                TODO: Logout to Settings Page, Add API
                ImagePicker(isVisibile: $showImagePicker, image: $image, sourceType: sourceType)
            }
        }
    }
    
    func UserLogout()  {
        self.loginData.Password = ""
        self.loginData.Username = ""
        self.loginData.hasLogin = false
    }
}



struct PicScapeYouView_Previews: PreviewProvider {
    static var previews: some View {
        PicScapeYouView()
            .environmentObject(UserBinding())
            .environmentObject(LoginBinding())
    }
}
