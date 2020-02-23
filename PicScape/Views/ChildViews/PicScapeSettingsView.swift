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
    
    @State private var ViewModel : PicScapeSettingsViewModel = PicScapeSettingsViewModel()
    
    var body: some View {
        //TODO: Make Settings Page
        VStack{
            List(){
                Button("Edit Profil",action: ViewModel.doNothing)
                Button("Test Picture",action: ViewModel.doNothing)
                Button("Edit Profil",action: ViewModel.doNothing)
                Button("Edit Profil",action: ViewModel.doNothing)
                    .buttonStyle(ButtonSettingStyle())
                Button("Edit Profil",action: ViewModel.doNothing)
                    .buttonStyle(ButtonSettingStyle())
                Button("Edit Profil",action: ViewModel.doNothing)
                    .buttonStyle(ButtonSettingStyle())
            }
            Spacer()
            Button("Test Auth", action: ViewModel.TestAuth)
                .buttonStyle(ButtonSettingStyle())
                .padding(.init(top: 0, leading: 0, bottom: 5, trailing: 0))
            
            Button("logout",action: ViewModel.UserLogout)
                .buttonStyle(ButtonSettingStyle())
                .padding(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        }.onAppear(){
            self.ViewModel = PicScapeSettingsViewModel(login: self.loginData, loading: self.loadingData, error: self.errorData, user: self.userData)
        }
    }
}

struct PicScapeSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        PicScapeSettingsView()
    }
}
