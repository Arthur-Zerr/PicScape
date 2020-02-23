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
    
    @State private var ViewModel : PicScapeRegisterViewModel = PicScapeRegisterViewModel()
    
    func Viewinit(){
        ViewModel = PicScapeRegisterViewModel(login: loginData, loading: loadingData, error: errorData)
    }
    
    var body: some View {
        VStack{
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
                Button("Register", action: userRegister)
                    .padding()
                    .accentColor(Color("ButtonColor"))
            }
        }.onAppear(){
            self.Viewinit()
        }
    }
    func userRegister(){
        self.ViewModel.Register(userForRegister: userForRegister)
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
