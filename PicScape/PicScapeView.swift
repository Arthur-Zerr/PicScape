//
//  PicScape.swift
//  PicScape
//
//  Created by Arthur Zerr on 21.12.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI

struct PicScapeView: View {
    @EnvironmentObject private var loginData : LoginBinding
    @EnvironmentObject private var errorData : ErrorBinding
    @EnvironmentObject private var loadingData : LoadingBinding
    @EnvironmentObject private var userData : UserBinding
    
    @State private var ViewModel : PicScapeViewModel = PicScapeViewModel()
    
    var body: some View {
        TabView(){
            PicScapeListView()
                .tabItem {
                    VStack {
                        Image("Home_icon")
                        Text("Following")
                    }
            }
            .tag(0)
            PicScapeNewView()
                .tabItem {
                    VStack {
                        Image("Lens_icon")
                        Text("World")
                    }
            }
            .tag(1)
            PicScapeMeView()
                .environmentObject(userData)
                .environmentObject(loginData)
                .environmentObject(errorData)
                .environmentObject(loadingData)
                .tabItem {
                    VStack {
                        Image("User_icon")
                        Text("Me")
                    }
            }
            .tag(2)
            }.accentColor(Color("TabViewColor"))
            .onAppear(){
                self.ViewModel = PicScapeViewModel(login: self.loginData, loading: self.loadingData, error: self.errorData, user: self.userData)
                debugPrint(self.loginData.Username)
                self.ViewModel.loadUserData(Username: self.loginData.Username)
                self.ViewModel.loadUserPicture(Username: self.loginData.Username)
        }
    }
}

struct PicScapeView_Previews: PreviewProvider {
    static var previews: some View {
        PicScapeView()
            .environmentObject(UserBinding())
            .environmentObject(ErrorBinding())
            .environmentObject(LoadingBinding())
            .environmentObject(LoginBinding())
    }
}
