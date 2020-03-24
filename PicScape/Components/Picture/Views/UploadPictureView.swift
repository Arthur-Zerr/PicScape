//
//  UploadPictureView.swift
//  PicScape
//
//  Created by Arthur Zerr on 16.03.20.
//  Copyright © 2020 ArthurZerr. All rights reserved.
//

import SwiftUI

struct UploadPictureView: View {
    @EnvironmentObject private var errorData : ErrorBinding
    @EnvironmentObject private var loadingData : LoadingBinding
    @EnvironmentObject private var userData : UserBinding
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var profileImage : Image = Image("User_icon")
    @State private var image : UIImage? = UIImage(named: "Add_icon")
    @State var pictureData : PictureDataDto = PictureDataDto(id: 0, userID: "", title: "", uploadDate: "")
    
    @State private var Title : String = ""
    @State private var Place : String = ""
    @State private var Caption : String = ""
    
    @State private var showImagePicker : Bool = false
    @State private var showAlert : Bool = false
    @State private var AlertMessage : String = ""
    
    var body: some View {
        VStack{
            HStack{
                profileImage
                    .resizable()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color("InvertColor"), lineWidth: 4))
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                VStack{
                    Text(userData.UserData.Username).font(.headline)
                    Text(pictureData.title).font(.subheadline)
                }
                Spacer()
            }.padding(EdgeInsets.init(top: 10, leading: 10, bottom: 0, trailing: 0))
            Spacer()
            VStack(alignment: .leading){
                PicScapeTextField(placeholder: Text("Title"), text: $Title)
                    .padding(.horizontal, 5)
                Divider().background(Color("InvertColor"))
                PicScapeTextField(placeholder: Text("Place"), text: $Place)
                    .padding(.horizontal, 5)
                Divider().background(Color("InvertColor"))
            }
            Button(action: self.modeImagePicker){
                Image(uiImage: self.image!)
                    .resizable()
                    .scaledToFit()
                    .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .overlay(Rectangle().stroke(Color("InvertColor"), lineWidth: 4).cornerRadius(4))
            }.buttonStyle(PlainButtonStyle())
            VStack{
                PicScapeTextField(placeholder: Text("Caption"), text: $Caption)
                    .padding(.horizontal, 5)
                Divider().background(Color("InvertColor"))
            }.padding(EdgeInsets.init(top: 5, leading: 0, bottom: 0, trailing: 0))
            Spacer()
            Button("Upload", action: self.uploadPicture).buttonStyle(PicScapeButtonStyle())
                .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 5, trailing: 0))
        }.edgesIgnoringSafeArea(.horizontal)
            .onAppear(){
                if let temp = PicScapeImageCache.Find(key: self.userData.UserData.Username, type: ECacheTypes.Profile_Picture){
                    self.profileImage = Image(uiImage: temp)
                }
        }.alert(isPresented: self.$showAlert) { () -> Alert in
                       Alert(title: Text("Info"), message: Text(AlertMessage), dismissButton: .default(Text("Got it!")))
                   }
        .sheet(isPresented: $showImagePicker){
            ImagePicker(isVisibile: self.$showImagePicker, image: self.$image , sourceType: 1).edgesIgnoringSafeArea(.bottom)
                .onDisappear(){
                    if self.image?.cgImage == nil{
                        self.image = UIImage(named: "Add_icon")
                    }
            }.onAppear(){
                self.image = UIImage()
            }
        }
    }
    
    func uploadPicture(){
        if Title == "" || Place == "" || Caption == "" {
            self.AlertMessage = "Please enter all information"
            self.showAlert = true
        }else {
            self.presentationMode.wrappedValue.dismiss()
            self.loadingData.Loading = true
            PicScapeAPI.UploadPicture(Picture: self.image!){ result in
                  switch result {
                  case .success(let responseData):
                      if responseData.success == true {
                          self.loadingData.Loading = false
                      }
                      else {
                          self.errorData.ShowError(message : responseData.message)
                          self.loadingData.Loading = false
                      }
                  case .failure(let error):
                      self.errorData.ShowError(message : error.localizedDescription)
                      self.loadingData.Loading = false
                  }
              }

        }
    }
    
    func modeImagePicker(){
        showImagePicker = !showImagePicker
    }
}

struct UploadPictureView_Previews: PreviewProvider {
    static var previews: some View {
        UploadPictureView()
            .environmentObject(ErrorBinding())
            .environmentObject(LoadingBinding())
            .environmentObject(UserBinding())
    }
}
