//
//  ContentView.swift
//  PicScape
//
//  Created by Arthur Zerr on 25.09.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State public static var TouchSelect = 0
    @State private var selection = TouchSelect
    
    @State public var Login : Bool = false
    @State private var Error : Bool = true
    @State private var Loading: Bool = false
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack{

            if Login == true{
                TabView(selection: $selection){
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
                    PicScapeYouView(user: User(id: 1, Username: "Arthur", UserPicUrl: "Arthur", FirstName: "Arthur", LastName: "Zerr", City: "", Country: ""))
                        .tabItem {
                            VStack {
                                Image("User_icon")
                                Text("You")
                            }
                        }
                        .tag(2)
                }.edgesIgnoringSafeArea(.top)
            }
            if Login == false{
                VStack{
                    if Error {
                        
                    }
                    VStack{
                        Text("PicScape")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                    }.padding(.init(top: 150, leading: 0, bottom: 0, trailing: 0))
                    VStack{
                        TextField("Username", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 250, height: 50)
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 250, height: 50)
                        Button("Login", action: UserLogin)
                            .padding()
                    }.animation(Animation.easeIn(duration: 5).delay(2))
                        .padding(.init(top: 150, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                    }.blur(radius: Loading ? 10: 0)
            }
            if Loading {
                VStack{
                    LoadingSpinner().frame(width: 75, height: 75)
                }.foregroundColor(Color("LoadingSpinnerColor"))
            }
        }
    }
    func UserLogin(){
        self.Loading = true
        PicScapeAPI.Login(username: self.username, password: self.password){ result in
            switch result {
                   case .success(_):
                        self.Login = true
                        self.Loading = false
                   case .failure(let error):
                       print(error.localizedDescription)
                       self.Loading = false
                   }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
