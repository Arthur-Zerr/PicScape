//
//  SinglePictureView.swift
//  PicScape
//
//  Created by Arthur Zerr on 12.03.20.
//  Copyright © 2020 ArthurZerr. All rights reserved.
//

import SwiftUI

struct SinglePictureView: View {
    @EnvironmentObject private var errorData : ErrorBinding
    @EnvironmentObject private var loadingData : LoadingBinding
    
    @State var profileImage : Image = Image("User_icon")
    var image : UIImage
    var id : Int
    
    @State var pictureData : PictureDataDto = PictureDataDto(id: 0, userID: "", title: "", uploadDate: "")
    @State var userData  : User = User(Id: "", Username: "", Firstname: "", LastName: "", City: "", Country: "")
    
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
                    Text(userData.Username).font(.headline)
                    Text(pictureData.title).font(.subheadline)
                }
                Spacer()
            }.padding(EdgeInsets.init(top: 10, leading: 10, bottom: 0, trailing: 0))
            Spacer()
            Image(uiImage: image)
                .resizable().scaledToFit().padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            Spacer()
        }.onAppear(){
            self.loadPictureData(id: self.id)
            
        }.edgesIgnoringSafeArea(.horizontal)
        
    }
    
    func loadPictureData(id : Int){
        PicScapeAPI.GetPictureData(Id: id){result in
            switch result{
            case .success(let responseData):
                self.pictureData = responseData
                self.loadUserData(id: self.pictureData.userID)
                break
            case .failure(let error):
                self.errorData.ShowError(message : error.localizedDescription)
                debugPrint(error)
                break
            }
        }
    }
    
    func loadUserData(id: String){
        
        
        PicScapeAPI.GetUserDataById(userId: id){result in
            switch result {
            case .success(let responseData):
                if(responseData.success == true){
                    self.userData = JsonConverter.convert(jsonString: responseData.data, as: User.self)
                    self.loadUserPicture(Username: self.userData.Username)
                }
            case .failure(let error):
                self.errorData.ShowError(message : error.localizedDescription)
            }
        }
    }
    
    func loadUserPicture(Username: String) {
        if let temp = PicScapeImageCache.Find(key: Username, type: ECacheTypes.Profile_Picture){
            profileImage = Image(uiImage: temp)
        }else {
            PicScapeAPI.GetProfilePicture(Username: Username) {result in
                switch result{
                case .success(let responseimage):
                    self.profileImage = Image(decorative: responseimage.cgImage!, scale: 1)
                    if PicScapeImageCache.Add(key: Username, type: ECacheTypes.Profile_Picture, item: UIImage(cgImage: responseimage.cgImage!)) == false{
                        self.errorData.ShowError(message: "Error Saving Picture")
                    }
                case .failure(let error):
                    self.errorData.ShowError(message: error.localizedDescription)
                }
            }
        }
    }
}

struct SinglePictureView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePictureView(image : UIImage(named: "User_icon")!, id : 0)
            .environmentObject(ErrorBinding())
            .environmentObject(LoadingBinding())
    }
}
