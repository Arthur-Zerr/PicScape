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
    @EnvironmentObject private var errorData : ErrorBinding
    @EnvironmentObject private var loadingData : LoadingBinding
    
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
                        Button("Test Auth", action: TestAuth).padding()
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
    
    func TestAuth() {
        self.loadingData.Loading = false
        PicScapeAPI.IsOnline(){ result in
            switch result {
            case .success(let responseData):
                if responseData.success == true {
                    self.ShowError(message: "Success API Token\(responseData.message)")
                    self.loadingData.Loading = false
                }
                else {
                    self.ShowError(message : responseData.message)
                    self.loadingData.Loading = false
                }
            case .failure(let error):
                self.ShowError(message : error.localizedDescription)
                self.loadingData.Loading = false
            }
        }
    }
    
    func UserLogout()  {
        self.loginData.Password = ""
        self.loginData.Username = ""
        self.loginData.hasLogin = false
        PicScapeKeychain.RemoveAPIToken()
        PicScapeKeychain.RemoveUserData()
    }
    
    func ShowError(message : String) {
        print(message)
        self.errorData.Message = message
        self.errorData.hasError = true
    }
}



struct PicScapeYouView_Previews: PreviewProvider {
    static var previews: some View {
        PicScapeYouView()
            .environmentObject(UserBinding())
            .environmentObject(LoginBinding())
            .environmentObject(ErrorBinding())
    }
}
