//
//  PicScapeRegisterView.swift
//  PicScape
//
//  Created by Arthur Zerr on 22.12.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI
import UIKit

struct PicScapeRegisterView: View {
    @EnvironmentObject private var loginData : LoginBinding
    @EnvironmentObject private var errorData : ErrorBinding
    @EnvironmentObject private var loadingData : LoadingBinding
    @EnvironmentObject private var userData : UserBinding
    
    @State private var userForRegister : UserForRegisterDto = UserForRegisterDto()
    @State private var userForUpdate : UserForUpdateDto = UserForUpdateDto()
    
    @State private var ViewModel : PicScapeRegisterViewModel = PicScapeRegisterViewModel()
    
    @State private var registerMode : Int = 0
    @State private var showImagePicker : Bool = false
    @State private var image : UIImage? = UIImage()
    @State private var registerProgress : Double = 25
    
    @State private var NextButton : String = "Next..."
    @State private var BackButton : String = "Back..."
    
    @State private var tempDate : Date = Date()
    func Viewinit(){
        ViewModel = PicScapeRegisterViewModel(login: loginData, loading: loadingData, error: errorData)
    }
    
    var body: some View {
        VStack{
            VStack{
                VStack{
                    Text("Register").font(.title)
                    Progressbar(value: $registerProgress.wrappedValue,width: 300)
                        .frame(width: 300, height: 10).fixedSize()
                    Spacer().frame(height: 50)
                }
                VStack{
                    if(registerMode == 0){
                        TextField("Username", text: $userForRegister.Username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 250, height: 50)
                        TextField("Email", text: $userForRegister.Email)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 250, height: 50)
                        SecureField("Password", text: $userForRegister.Password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 250, height: 50)
                        SecureField("Confirm Password", text: $userForRegister.ConfirmPassword)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 250, height: 50)
                    }
                    else if(registerMode == 1){
                        TextField("Name", text: $userForUpdate.Name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 250, height: 50)
                        TextField("Firstname", text: $userForUpdate.Firstname)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 250, height: 50)
                        TextField("City", text: $userForUpdate.City)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 250, height: 50)
                        TextField("Country", text: $userForUpdate.Country)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 250, height: 50)
                    }
                    else if (registerMode == 2){
                        VStack{
                            DatePicker(selection: $tempDate, in: ...Date(), displayedComponents: .date){
                                Text("")
                                }.offset(x: -50, y: 0)
                        }
                    }
                    else if(registerMode == 3){
                        Button(action: self.modeImagePicker) {
                            Text("Profile Picture")
                            userData.UserPicture?
                                .resizable()
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color("InvertColor"), lineWidth: 4))
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150, height: 150)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
                Spacer().frame(height: 20)
                HStack{
                    Button(BackButton, action: backRegisterMode)
                        .padding()
                        .accentColor(Color("ButtonColor"))
                    Button(NextButton, action: nextRegisterMode)
                        .padding()
                        .accentColor(Color("ButtonColor"))
                }
            }
        }.onAppear(){
            self.Viewinit()
        }.sheet(isPresented: $showImagePicker){
            ImagePicker(isVisibile: self.$showImagePicker, image: self.$image , sourceType: 1).edgesIgnoringSafeArea(.bottom)
                .onDisappear(){
                    if(self.image?.cgImage != nil){
                        self.userData.UserPicture = Image(uiImage: self.image!)
                    }
            }
            .onAppear(){
                self.image = UIImage()
            }
        }
    }
    func userRegister(){
        self.ViewModel.Register(userForRegister: userForRegister, userForUpdate: userForUpdate, selectedImage: image)
        self.ViewModel.UpdateData(userForUpdate: userForUpdate, selectedImage: image)
    }
    
    func nextRegisterMode(){
        registerMode += 1
        NextButton = self.registerMode == 3 ? "Register" : "Next..."
        if(self.registerMode == 4){
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            self.userForUpdate.Birthday = df.string(from: self.tempDate)
            self.ViewModel.Register(userForRegister: self.userForRegister, userForUpdate: self.userForUpdate, selectedImage: self.image)
        }
        
        registerProgress = Double(registerProgress + 25)
    }
    
    func backRegisterMode(){
        NextButton = self.registerMode == 3 ? "Register" : "Next..."
        if(registerMode <= 0){
            self.loginData.loginMode = true
        }
        registerMode -= 1
        registerProgress = Double(registerProgress - 25)
    }
    func modeImagePicker(){
        self.showImagePicker = !showImagePicker
    }
    
}

struct PicScapeRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        PicScapeRegisterView()
            .environmentObject(LoginBinding())
            .environmentObject(ErrorBinding())
            .environmentObject(LoadingBinding())
    }
}
