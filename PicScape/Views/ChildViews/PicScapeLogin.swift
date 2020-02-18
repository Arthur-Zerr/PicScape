//
//  PicScapeLogin.swift
//  PicScape
//
//  Created by Arthur Zerr on 21.12.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI

struct PicScapeLogin: View {
    @EnvironmentObject private var loginData : LoginBinding
    @EnvironmentObject private var errorData : ErrorBinding
    @EnvironmentObject private var loadingData : LoadingBinding
    @EnvironmentObject private var userData : UserBinding
    
    var body: some View {
        VStack{
            VStack{
                TextField("Username", text: $loginData.Username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250, height: 50)
                    
                SecureField("Password", text: $loginData.Password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250, height: 50)
                Button("Login", action: Login)
                    .padding()
                    .accentColor(Color("ButtonColor"))
            }.animation(Animation.easeIn(duration: 5).delay(2))
                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }.onAppear(){
            if PicScapeKeychain.HasUserData() {
                self.UserLogin(Username: PicScapeKeychain.GetUserUsername(), Password: PicScapeKeychain.GetUserPassword() )
            } 
        }.disabled(self.loadingData.Loading)
    }
    
    func Login() {
        UserLogin(Username: loginData.Username, Password: loginData.Password)
    }
    
    func UserLogin(Username: String, Password: String){
        self.loadingData.Loading = true
        let login = UserForLoginDto(Username: Username, Password: Password)
        PicScapeAPI.Login(loginData: login){ result in
            switch result {
            case .success(let responseData):
                if responseData.success == true {
                    PicScapeKeychain.SaveUserData(Username: Username, Password: Password)
                    PicScapeKeychain.SaveAPIToken(Token: responseData.data)
                    self.loginData.hasLogin = true
                    self.loadingData.Loading = false
                    self.loadUserData(username: Username)
                    self.loadUserPicture(username: Username)
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
    
    func loadUserData(username : String){
        self.loadingData.Loading = true
        PicScapeAPI.GetUserData(userId: username){result in
            switch result {
            case .success(let responseData):
                if(responseData.success == true){
                    self.userData.UserData = JsonConverter.convert(jsonString: responseData.data, as: User.self)
                    self.loadingData.Loading = false
                }
            case .failure(let error):
                self.errorData.ShowError(message : error.localizedDescription)
                self.loadingData.Loading = false
            }
        }
    }
    
    func loadUserPicture(username : String){
        self.loadingData.Loading = true
        PicScapeAPI.GetUserPicture(Username: username) {result in
            switch result{
            case .success(let responseimage):
                self.userData.UserPicture = Image(decorative: responseimage.cgImage!, scale: 1)
                debugPrint(responseimage)
                self.loadingData.Loading = false
            case .failure(let error):
                self.errorData.ShowError(message: error.localizedDescription)
                self.loadingData.Loading = false
            }
        }
    }
}

struct PicScapeLogin_Previews: PreviewProvider {
    static var previews: some View {
        PicScapeLogin()
            .environmentObject(LoginBinding())
            .environmentObject(ErrorBinding())
            .environmentObject(LoadingBinding())
    }
}
