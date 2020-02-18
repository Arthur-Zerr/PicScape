//
//  PicScapeRegisterView.swift
//  PicScape
//
//  Created by Arthur Zerr on 22.12.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI

struct PicScapeRegisterView: View {
    @EnvironmentObject private var loginData : LoginBinding
    @EnvironmentObject private var errorData : ErrorBinding
    @EnvironmentObject private var loadingData : LoadingBinding
    
    @State private var userForRegister : UserForRegisterDto = UserForRegisterDto()
    
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmpassword: String = ""
    
    var body: some View {
        VStack{
            VStack{
                TextField("Username", text: $username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250, height: 50)
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250, height: 50)
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250, height: 50)
                SecureField("Confirm Password", text: $confirmpassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250, height: 50)
                Button("Register", action: userRegister)
                    .padding()
                    .accentColor(Color("ButtonColor"))
            }
        }
    }
    
    func userRegister() {
        self.loadingData.Loading = true
        let registerData : UserForRegisterDto = UserForRegisterDto(Username: self.username, Email: self.email, Password: self.password, ConfirmPassword: self.confirmpassword)
        PicScapeAPI.Register(registerData: registerData){ result in
            switch result {
            case .success(let responseData):
                if responseData.success == true {
                    self.loginData.hasLogin = true
                    PicScapeKeychain.SaveAPIToken(Token: responseData.data)
                    PicScapeKeychain.SaveUserData(Username: self.username, Password: self.password)
                    self.loadingData.Loading = false
                }
                else {
                    self.errorData.ShowError(message: responseData.message)
                    self.loadingData.Loading = false
                }
            case .failure(let error):
                self.errorData.ShowError(message: error.localizedDescription)
                self.loadingData.Loading = false
            }
        }
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
