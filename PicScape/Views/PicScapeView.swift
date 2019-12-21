//
//  PicScape.swift
//  PicScape
//
//  Created by Arthur Zerr on 21.12.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI

struct PicScapeView: View {
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
            PicScapeYouView(user: User(id: 1, Username: "Arthur", UserPicUrl: "Arthur", FirstName: "Arthur", LastName: "Zerr", City: "", Country: ""))
                .tabItem {
                    VStack {
                        Image("User_icon")
                        Text("You")
                    }
            }
            .tag(2)
        }
    }
}

struct PicScapeView_Previews: PreviewProvider {
    static var previews: some View {
        PicScapeView()
    }
}
