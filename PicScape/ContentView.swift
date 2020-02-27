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
                        Spacer().frame(height: 75).fixedSize()
                        VStack{
                            Text("PicScape")
                                .font(.largeTitle)
                                .fontWeight(.heavy)
                        }
                        VStack{
                            if self.loginData.loginMode  == true {
                                Spacer().frame(height: 150).fixedSize()
                                PicScapeLoginView()
                                    .environmentObject(loginData)
                                    .environmentObject(errorData)
                                    .environmentObject(loadingData)
                            }
                            if self.loginData.loginMode  == false {
                                Spacer().frame(height: 125).fixedSize()
                                PicScapeRegisterView()
                                    .environmentObject(loginData)
                                    .environmentObject(errorData)
                                    .environmentObject(loadingData)
                            }
                        }
                        Spacer()
                        if(self.loginData.loginMode == true){
                            Button("Or Register", action: {
                                withAnimation{
                                    self.changeMode()
                                }
                            }).accentColor(Color("ButtonColor")).offset(x: 0, y: 100)
                        }
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
        self.loginData.loginMode = !self.loginData.loginMode
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
