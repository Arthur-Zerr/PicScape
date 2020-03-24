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
            self.loadingData.Show()
            PicScapeAPI.GetUserDataByName(username: Username){result in
                switch result {
                case .success(let responseData):
                    if(responseData.success == true){
                        self.userData.UserData = JsonConverter.convert(jsonString: responseData.data, as: User.self)
                        self.loadingData.Close()
                    }
                case .failure(let error):
                    self.errorData.ShowError(message : error.localizedDescription)
                    self.loadingData.Loading = false
                }
            }
        }
        
        func loadUserPicture(Username: String){
            if let _ = PicScapeImageStorage.Find(key: Username, type: EStorageType.Profile_Picture){
                return 
            }
            
            self.loadingData.Show()
            PicScapeAPI.GetProfilePicture(Username: Username) {result in
                switch result{
                case .success(let responseimage):
                    if PicScapeImageStorage.AddOrUpdate(key: Username, type: EStorageType.Profile_Picture, item: UIImage(cgImage: responseimage.cgImage!)) == false{
                        self.loadingData.Close()
                    }
                    self.loadingData.Loading = false
                case .failure(let error):
                    self.errorData.ShowError(message: error.localizedDescription)
                    self.loadingData.Close()
                }
            }
        }
        
        
    }
}
