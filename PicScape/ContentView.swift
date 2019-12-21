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

    var body: some View {
        ZStack{
            if self.loginData.hasLogin == true{
                    PicScapeView().edgesIgnoringSafeArea(.top)
            }
            if self.loginData.hasLogin == false{
                PicScapeLogin()
                    .environmentObject(loginData)
                    .environmentObject(errorData)
                    .environmentObject(loadingData)
                    .blur(radius: self.loadingData.Loading ? 10: 0)
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
    }
}
