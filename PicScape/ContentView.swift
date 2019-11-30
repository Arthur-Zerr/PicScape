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
 
    var body: some View {
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
