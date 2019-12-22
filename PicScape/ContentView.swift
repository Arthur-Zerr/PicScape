//
//  ContentView.swift
//  PicScape
//
//  Created by Arthur Zerr on 25.09.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var loginData : LoginBinding
    @EnvironmentObject private var errorData : ErrorBinding
    @EnvironmentObject private var loadingData : LoadingBinding
    
    @EnvironmentObject private var userData : UserBinding
    
    
    init() {
        //        UITabBar.appearance().W
    }
    
    var body: some View {
        ZStack{
            if self.loginData.hasLogin == true{
                PicScapeView()
                    .environmentObject(loginData)
                    .environmentObject(errorData)
                    .environmentObject(loadingData)
                    .environmentObject(userData)
                    .edgesIgnoringSafeArea(.top)
            }
            if self.loginData.hasLogin == false{
                VStack{
                    VStack{
                        Text("PicScape")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                    }.padding(.init(top: 150, leading: 0, bottom: 0, trailing: 0))
                    TabView(){
                        PicScapeLogin()
                            .environmentObject(loginData)
                            .environmentObject(errorData)
                            .environmentObject(loadingData)
                            .tabItem {
                                VStack {
                                    Text("Login")
                                }
                        }
                        .tag(0)
                        
                        PicScapeRegisterView()
                            .environmentObject(loginData)
                            .environmentObject(errorData)
                            .environmentObject(loadingData)
                            .tabItem {
                                VStack {
                                    Text("Register")
                                }
                        }
                        .tag(1)
                    }.blur(radius: self.loadingData.Loading ? 10: 0)
                }
            }
            if self.loadingData.Loading {
                VStack{
                    LoadingSpinner().frame(width: 75, height: 75)
                }.foregroundColor(Color("LoadingSpinnerColor"))
            }
        }.alert(isPresented: $errorData.hasError) { () -> Alert in
            Alert(title: Text("Error"), message: Text(errorData.Message), dismissButton: .default(Text("Got it!")))
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(LoginBinding())
            .environmentObject(ErrorBinding())
            .environmentObject(LoadingBinding())
            .environmentObject(UserBinding())
    }
}
