//
//  PicScapeViewModel.swift
//  PicScape
//
//  Created by Arthur Zerr on 19.02.20.
//  Copyright © 2020 ArthurZerr. All rights reserved.
//

import Foundation
import SwiftUI

extension PicScapeView{
    class PicScapeViewModel: ObservableObject{
        
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
        
        func loadUserData(Username: String){
            self.loadingData.Loading = true
            PicScapeAPI.GetUserData(userId: Username){result in
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
        func loadUserPicture(Username: String){
            self.loadingData.Loading = true
            PicScapeAPI.GetProfilePicture(Username: Username) {result in
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
}
