//
//  PicScapeYouView.swift
//  PicScape
//
//  Created by Arthur Zerr on 18.11.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI
import WaterfallGrid
import MapKit

struct PicScapeMeView: View {
    @State private var selectorIndex: Int = 0
    
    @EnvironmentObject private var userData : UserBinding
    @EnvironmentObject private var loginData : LoginBinding
    @EnvironmentObject private var errorData : ErrorBinding
    @EnvironmentObject private var loadingData : LoadingBinding
    
    @State private var image : UIImage? = UIImage()
    
    @State private var showSettings : Bool = false
    @State private var showImagePicker : Bool = false
    
    @State var ViewModel: PicScapeMeViewModel = PicScapeMeViewModel()
    
    var body: some View {
        VStack{
            if(self.showSettings == true){
                VStack{
                    Color("SettingsTitleColor").edgesIgnoringSafeArea(.top)
                        .opacity(1)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: Alignment.topLeading)
                        .overlay(
                            Group{
                                HStack{
                                    Spacer()
                                    Text("Settings").font(.system(size: 25)).foregroundColor(Color("InvertColor"))
                                        .padding(.init(top: 0, leading: 90, bottom: 0, trailing: 0))
                                    Spacer()
                                    Button(action: {
                                        withAnimation{
                                            self.modeSettings()
                                        }
                                    }){
                                        Text("go back").underline()
                                    }.padding()
                                }
                            }.accentColor(Color("InvertColor"))
                    )
                    PicScapeSettingsView()
                }.transition(.move(edge: .trailing)).animation(.easeInOut(duration: 0.5))
            }
            else{
                VStack{
                    VStack{
                        Button(action: self.modeImagePicker) {
                            userData.UserPicture?
                                .resizable()
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color("InvertColor"), lineWidth: 4))
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                        }.buttonStyle(PlainButtonStyle())
                        
                        HStack{
                            Spacer()
                            Text((userData.UserData.Username == "") ? "Username" : userData.UserData.Username)
                                .fontWeight(.bold).padding(.init(top: 0, leading: 40, bottom: 0, trailing: 0))
                            Spacer()
                            Button(action: {
                                withAnimation{
                                    self.modeSettings()
                                }
                            }){
                                Image("Settings_Icon").resizable().frame(width: 40, height: 40).foregroundColor(Color("ButtonColor"))
                            }
                        }
                    }
                    Divider().background(Color("InvertColor")).padding(.init(top: -15, leading: 5, bottom: 0, trailing: 5))
                    VStack{
                        Picker("Numbers", selection: $selectorIndex) {
                            Text("All").tag(0)
                            Text("Visited Places").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        if selectorIndex == 0 {
                            VStack {
                                Text("All")
                                Spacer()
                            }
                        }
                        if selectorIndex == 1 {
                            MapView(coordinate: CLLocationCoordinate2D(
                                latitude: 1,
                                longitude: 1))
                        }
                    }.padding(.init(top: -15, leading: 0, bottom: 0, trailing: 0))
                }
            }
        }.onAppear(){
            self.ViewModel = PicScapeMeViewModel(login: self.loginData, loading: self.loadingData, error: self.errorData, user: self.userData)
        }.sheet(isPresented: $showImagePicker){
            ImagePicker(isVisibile: self.$showImagePicker, image: self.$image , sourceType: 1).edgesIgnoringSafeArea(.bottom)
                .onDisappear(){
                    self.uploadPicture()
            }.onAppear(){
                self.image = UIImage()
            }
        }
    }
    
    func uploadPicture(){
        ViewModel.UploadPicture(selectedImage: self.image)
    }
    
    func modeImagePicker(){
        showImagePicker = !showImagePicker
    }
    
    func modeSettings() {
        showSettings = !showSettings
    }
    
}

struct PicScapeMeView_Previews: PreviewProvider {
    static var previews: some View {
        PicScapeMeView()
            .environmentObject(UserBinding())
            .environmentObject(LoginBinding())
            .environmentObject(ErrorBinding())
    }
}
