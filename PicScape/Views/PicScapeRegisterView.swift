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
    
    @State private var registerSuccessful : Bool = false
    var body: some View {
        VStack{
            VStack{
                if registerSuccessful == false {
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
                    Button("Register", action: userRegister).padding()
                    
                }
                if registerSuccessful == true {
                    VStack{
                        Text("Register Sucessfull! ")
                        Text("Please Login with your Account Data!")
                    }
                }
            }//.animation(Animation.easeIn(duration: 5).delay(2))
                .padding(.init(top: 150, leading: 0, bottom: 0, trailing: 0))
            Spacer()
            
        }
    }
    
    func userRegister() {
        self.loadingData.Loading = true
        let registerData : UserForRegisterDto = UserForRegisterDto(Username: self.username, Email: self.email, Password: self.password, ConfirmPassword: self.confirmpassword)
        PicScapeAPI.Register(registerData: registerData){ result in
            switch result {
            case .success(let responseData):
                if responseData.success == true {
                    self.registerSuccessful = true
                }
                else {
                    print(responseData.message)
                    self.errorData.Message = responseData.message
                    self.errorData.hasError = true
                }
            case .failure(let error):
                print(error)
                self.errorData.Message = error.localizedDescription
                self.errorData.hasError = true
            }
        }
        self.loadingData.Loading = false
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
