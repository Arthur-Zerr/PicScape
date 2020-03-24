//
//  PicScapeSettingsViewModel.swift
//  PicScape
//
//  Created by Arthur Zerr on 19.02.20.
//  Copyright © 2020 ArthurZerr. All rights reserved.
//

import Foundation
import SwiftUI

extension PicScapeSettingsView {
    class PicScapeSettingsViewModel : ObservableObject{
        
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
        
        
        private func logoutUser(){
            self.userData.UserData = User(Id: "", Username: "", Firstname: "", LastName: "", City: "", Country: "")
            PicScapeImageCache.RemoveAll()
            self.loginData.hasLogin = false
            PicScapeKeychain.RemoveAPIToken()
            PicScapeKeychain.RemoveUserData()
        }
        
        func UserLogout()  {
            self.loadingData.Loading = true;
            PicScapeAPI.Logout(logoutData: UserForLogoutDto(UserId: self.userData.UserData.Id, Username: self.userData.UserData.Username)) { result in
                switch result {
                case .success(let responseData):
                    if responseData.success == true {
                        self.logoutUser()
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
        func doNothing(){}
        
        func TestAuth() {
            self.loadingData.Loading = true
            PicScapeAPI.IsOnline(){ result in
                switch result {
                case .success(let responseData):
                    if responseData.success == true {
                        self.errorData.ShowInformation(message: responseData.message)
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
