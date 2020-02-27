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
    @State private var registerProgress : Double = 0
    
    @State private var NextButton : String = "Start..."
    @State private var BackButton : String = "Back..."
    
    @State private var tempDate : Date = Date()
    
    @State private var NextAnimationEdge : Edge = .trailing
    @State private var BackAnimationEdge : Edge = .leading
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
                }.animation(.easeInOut)
                VStack{
                    if(registerMode == 0){
                        Text("Lets Start")
                    }
                    if(registerMode == 1){
                        VStack{
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
                        }.transition(AnyTransition.asymmetric(insertion: .move(edge: NextAnimationEdge), removal: .move(edge: BackAnimationEdge)).combined(with: .opacity))
                    }
                    else if(registerMode == 2){
                        VStack{
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
                        }.transition(AnyTransition.asymmetric(insertion: .move(edge: NextAnimationEdge), removal: .move(edge: BackAnimationEdge)).combined(with: .opacity))
                    }
                    else if (registerMode == 3){
                        VStack{
                            DatePicker(selection: $tempDate, in: ...Date(), displayedComponents: .date){
                                Text("")
                            }.offset(x: -50, y: 0)
                        }.transition(AnyTransition.asymmetric(insertion: .move(edge: NextAnimationEdge), removal: .move(edge: BackAnimationEdge)).combined(with: .opacity))
                    }
                    else if(registerMode == 4){
                        VStack{
                            Button(action: self.modeImagePicker) {
                                Text("Profile Picture")
                                userData.UserPicture?
                                    .resizable()
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color("InvertColor"), lineWidth: 4))
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 150, height: 150)
                            }.buttonStyle(PlainButtonStyle())
                        }.transition(AnyTransition.asymmetric(insertion: .move(edge: NextAnimationEdge), removal: .move(edge: BackAnimationEdge)).combined(with: .opacity))
                    }
                    else if(registerMode == 5){
                        VStack{
                            Text("Finished")
                        }.transition(AnyTransition.asymmetric(insertion: .move(edge: NextAnimationEdge), removal: .move(edge: BackAnimationEdge)).combined(with: .opacity))
                    }
                }
                Spacer().frame(height: 20)
                HStack{
                    Button(BackButton, action: {
                        withAnimation{
                            self.backRegisterMode()
                        }
                    }).padding()
                        .accentColor(Color("ButtonColor"))
                    Button(NextButton, action: {
                        withAnimation{
                            self.nextRegisterMode()
                        }
                    }).padding()
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
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        self.userForUpdate.Birthday = df.string(from: self.tempDate)
        self.ViewModel.Register(userForRegister: self.userForRegister, userForUpdate: self.userForUpdate, selectedImage: self.image)
    }
    
    func nextRegisterMode(){
        if(ValidateForm() == false){
            return
        }
        BackAnimationEdge = .leading
        NextAnimationEdge = .trailing
        if(self.registerMode == 5){
            userRegister()
        }
        else {
            registerMode += 1
            UpdateButtonText()
            registerProgress = Double(registerProgress + 20)
        }
    }
    
    func ValidateForm() -> Bool{
        switch(registerMode){
        case 1:
            if(self.ViewModel.ValidateUserForRegister(toValidate: userForRegister) == false){
                self.errorData.Message = "Please Check your input!"
                self.errorData.hasError = true
                return false
            }
            break
        case 2:
            if(self.ViewModel.ValidateUserForUpdate(toValidate: userForUpdate) == false){
                self.errorData.Message = "Please Check your input!"
                self.errorData.hasError = true
                return false
            }
            break
        case 3:
            if(self.ViewModel.ValidateBirhtday(toValidate: tempDate) == false ){
                self.errorData.Message = "Please enter your Birthday!"
                self.errorData.hasError = true
                return false
            }
            break
        default:
            break
            
        }
        return true
    }
    
    func backRegisterMode(){
        BackAnimationEdge = .trailing
        NextAnimationEdge = .leading
        if(registerMode <= 0){
            self.loginData.loginMode = true
        }else {
            registerMode -= 1
            registerProgress = Double(registerProgress - 20)
        }
        UpdateButtonText()
    }
    
    func UpdateButtonText(){
        if(registerMode == 0){
            NextButton = "Start..."
        }else {
            NextButton = self.registerMode == 5 ? "Register" : "Next..."
        }
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
