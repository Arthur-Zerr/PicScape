//
//  PicScapeLoginViewModel.swift
//  PicScape
//
//  Created by Arthur Zerr on 18.02.20.
//  Copyright © 2020 ArthurZerr. All rights reserved.
//

import Foundation

extension PicScapeLoginView{
    class PicScapeLoginViewModel : ObservableObject{
        
        private var loginData : LoginBinding = LoginBinding()
        private var errorData : ErrorBinding = ErrorBinding()
        private var loadingData : LoadingBinding = LoadingBinding()
        private var userData : UserBinding = UserBinding()
        
        init() {
        }
        
        init(login: LoginBinding, loading: LoadingBinding, error: ErrorBinding, user: UserBinding) {
            self.loginData = login
            self.loadingData = loading
            self.errorData = error
            self.userData = user
        }

        func Login(Username: String, Password: String){
            self.loadingData.Loading = true
            let login = UserForLoginDto(Username: Username, Password: Password)
            PicScapeAPI.Login(loginData: login){ result in
                switch result {
                case .success(let responseData):
                    if responseData.success == true {
                        PicScapeKeychain.SaveUserData(Username: Username, Password: Password)
                        PicScapeKeychain.SaveAPIToken(Token: responseData.data)
                        self.loginData.Username = Username
                        self.loginData.Password = Password
                        self.loginData.hasLogin = true
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
}
