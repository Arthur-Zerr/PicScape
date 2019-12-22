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
    
    var body: some View {
        VStack{
            VStack{
                TextField("Username", text: $loginData.Username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250, height: 50)
                SecureField("Password", text: $loginData.Password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250, height: 50)
                Button("Login", action: UserLogin).padding()
            }.animation(Animation.easeIn(duration: 5).delay(2))
                .padding(.init(top: 150, leading: 0, bottom: 0, trailing: 0))
            Spacer()
        }
    }
    
    func UserLogin(){
        self.loadingData.Loading = true
        PicScapeAPI.Login(loginData: self.loginData){ result in
            switch result {
            case .success(let responseData):
                if responseData.success == true {
                    self.loginData.hasLogin = true
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

struct PicScapeLogin_Previews: PreviewProvider {
    static var previews: some View {
        PicScapeLogin()
            .environmentObject(LoginBinding())
            .environmentObject(ErrorBinding())
            .environmentObject(LoadingBinding())
    }
}
