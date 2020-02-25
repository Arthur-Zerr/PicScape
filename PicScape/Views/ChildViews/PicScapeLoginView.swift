//
//  PicScapeLogin.swift
//  PicScape
//
//  Created by Arthur Zerr on 21.12.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI

struct PicScapeLoginView: View {
    @State var Username : String = ""
    @State var Password: String = ""
    
    @EnvironmentObject private var loginData : LoginBinding
    @EnvironmentObject var errorData : ErrorBinding
    @EnvironmentObject var loadingData : LoadingBinding
    @EnvironmentObject var userData : UserBinding
    
    @State private var ViewModel : PicScapeLoginViewModel = PicScapeLoginViewModel()
    
    var body: some View {
        VStack{
            Text("Login").font(.title).padding()
            VStack{
                TextField("Username", text: $Username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250, height: 50)
                SecureField("Password", text: $Password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250, height: 50)
                Button("Login", action: self.login)
                    .padding()
                    .accentColor(Color("ButtonColor"))
            }.animation(Animation.easeIn(duration: 5).delay(2))
                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }.onAppear(){
            self.ViewModel = PicScapeLoginViewModel(login: self.loginData, loading: self.loadingData, error: self.errorData, user: self.userData)
            if PicScapeKeychain.HasUserData() {
                self.Username = PicScapeKeychain.GetUserUsername()
                self.Password = PicScapeKeychain.GetUserPassword()
                self.login()
            } 
        }.disabled(self.loadingData.Loading)
    }
    
    func login(){
        self.ViewModel.Login(Username: Username, Password: Password)
    }
    
}

struct PicScapeLoginView_Previews: PreviewProvider {
    static var previews: some View {
        PicScapeLoginView()
    }
}
