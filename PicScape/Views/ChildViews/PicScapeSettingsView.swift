//
//  PicScapeSettingsView.swift
//  PicScape
//
//  Created by Arthur Zerr on 22.12.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI

struct PicScapeSettingsView: View {
    @EnvironmentObject private var userData : UserBinding
    @EnvironmentObject private var loginData : LoginBinding
    @EnvironmentObject private var errorData : ErrorBinding
    @EnvironmentObject private var loadingData : LoadingBinding
    
    var body: some View {
        //TODO: Make Settings Page
        VStack{
            List(){
                    Button("Edit Profil",action: doNothing)

                Button("Test Picture",action: doNothing)
                Button("Edit Profil",action: doNothing)
                Button("Edit Profil",action: doNothing)
                .buttonStyle(ButtonSettingStyle())
                Button("Edit Profil",action: doNothing)
                .buttonStyle(ButtonSettingStyle())
                Button("Edit Profil",action: doNothing)
                .buttonStyle(ButtonSettingStyle())
            }
            
            Spacer()
            Button("Test Auth", action: TestAuth)
            .buttonStyle(ButtonSettingStyle())
            .padding(.init(top: 0, leading: 0, bottom: 5, trailing: 0))
            
            Button("logout",action: UserLogout)
            .buttonStyle(ButtonSettingStyle())
                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }
    
    func UserLogout()  {
        self.loginData.Password = ""
        self.loginData.Username = ""
        self.userData.UserData = User(Id: "", Username: "", Firstname: "", LastName: "", City: "", Country: "")
        self.loginData.hasLogin = false
        PicScapeKeychain.RemoveAPIToken()
        PicScapeKeychain.RemoveUserData()
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

struct PicScapeSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        PicScapeSettingsView()
    }
}
