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
                        Text("All")
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
        }
    }
}

struct PicScapeView_Previews: PreviewProvider {
    static var previews: some View {
        PicScapeView()
            .environmentObject(UserBinding())
    }
}
