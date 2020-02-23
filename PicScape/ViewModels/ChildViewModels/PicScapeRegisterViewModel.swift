//
//  PicScapeRegisterViewModel.swift
//  PicScape
//
//  Created by Arthur Zerr on 19.02.20.
//  Copyright © 2020 ArthurZerr. All rights reserved.
//

import Foundation

extension PicScapeRegisterView{
    class PicScapeRegisterViewModel : ObservableObject{
        private var loginData : LoginBinding = LoginBinding()
        private var errorData : ErrorBinding = ErrorBinding()
        private var loadingData : LoadingBinding = LoadingBinding()
        
        init() {
        }
        
        init(login: LoginBinding, loading: LoadingBinding, error: ErrorBinding) {
            self.loginData = login
            self.loadingData = loading
            self.errorData = error
        }
        
        func Register(userForRegister : UserForRegisterDto) {
            self.loadingData.Loading = true
            PicScapeAPI.Register(registerData: userForRegister){ result in
                switch result {
                case .success(let responseData):
                    if responseData.success == true {
                        self.loginData.hasLogin = true
                        PicScapeKeychain.SaveAPIToken(Token: responseData.data)
                        PicScapeKeychain.SaveUserData(Username: userForRegister.Username, Password: userForRegister.Password)
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
}
