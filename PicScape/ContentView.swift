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
    
    
    @State private var LoginMode : Bool = true
    @State private var ModeButton : String = "Or Register?"
    
    init() {
    }
    
    var body: some View {
        ZStack{
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
                        Spacer()
                        VStack{
                            Text("PicScape")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                        }
                        Spacer()
                        Spacer()
                        VStack{
                            if LoginMode == true {
                                PicScapeLogin()
                                    .environmentObject(loginData)
                                    .environmentObject(errorData)
                                    .environmentObject(loadingData)
                            }
                            if LoginMode == false {
                                PicScapeRegisterView()
                                    .environmentObject(loginData)
                                    .environmentObject(errorData)
                                    .environmentObject(loadingData)
                            }
                            Button(ModeButton, action: changeMode).accentColor(Color("ButtonColor"))
                        }
                        Spacer()
                        Spacer()
                        VStack{
                            Text("FROM").font(.subheadline)
                            Text("PKC Studio").font(.headline)
                        }.padding(.init(top: 50, leading: 1, bottom: 0, trailing: 0))
                    }
                }
            }.blur(radius: self.loadingData.Loading ? 10: 0).disabled(self.loadingData.Loading)
            if self.loadingData.Loading {
                VStack{
                    LoadingSpinner().frame(width: 75, height: 75)
                }.foregroundColor(Color("LoadingSpinnerColor"))
            }
        }.alert(isPresented: $errorData.hasError) { () -> Alert in
            Alert(title: Text(errorData.Title), message: Text(errorData.Message), dismissButton: .default(Text("Got it!")))
        }
    }
    func changeMode(){
        self.LoginMode = !self.LoginMode
        if(LoginMode == true){ModeButton = "Or Register?"}
        else {ModeButton = "Or Login?"}
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
