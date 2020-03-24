//
//  PicScapeYouView.swift
//  PicScape
//
//  Created by Arthur Zerr on 18.11.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import SwiftUI
import MapKit

struct PicScapeMeView: View {
    @State private var selectorIndex: Int = 0
    
    @EnvironmentObject private var userData : UserBinding
    @EnvironmentObject private var loginData : LoginBinding
    @EnvironmentObject private var errorData : ErrorBinding
    @EnvironmentObject private var loadingData : LoadingBinding
    
    @State private var image : UIImage? = UIImage()
    
    @State private var showSheet : Bool = false
    @State private var showSettings : Bool = false
    @State private var showImagePicker : Bool = false
    @State private var showUploadPhoto : Bool = false
    @State private var showBigPicture : Bool = false
    
    @State private var bigPictureId : Int = 0
    @State private var bigPicture : UIImage? = UIImage()
    
    @State var ViewModel: PicScapeMeViewModel = PicScapeMeViewModel()
    
    @State var UserPicture : Image = Image("User_icon")
    
    @ObservedObject var tempList = ObservableArray<PictureListModel>(array: [PictureListModel]())
    @State private var showList : [[PictureListModel]] = [[PictureListModel]]()
    
    var body: some View {
        VStack{
            VStack{
                VStack{
                    Button(action: self.modeImagePicker) {
                        UserPicture
                            .resizable()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color("InvertColor"), lineWidth: 4))
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                    }.buttonStyle(PlainButtonStyle())
                    
                    HStack{
                        Button(action: {
                            self.modeUploadPhoto()
                            
                        }){
                            Image("Add_icon").resizable().frame(width: 40, height: 40).foregroundColor(Color("ButtonColor"))
                        }
                        Spacer()
                        Text((userData.UserData.Username == "") ? "Username" : userData.UserData.Username)
                            .fontWeight(.bold).padding(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                        Spacer()
                        Button(action: {
                            self.modeSettings()
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
                        List{
                            ForEach(0 ..< showList.count, id: \.self){ item in
                                HStack{
                                    ForEach(self.showList[item], id:\.self) { imageItem in
                                        Image(uiImage: imageItem.image).resizable()
                                            .scaledToFit()
                                            .onAppear(){
                                                let count = self.tempList.array.count
                                                if imageItem.id == self.tempList.array.last?.id ?? 0{
                                                    self.ViewModel.getNewItems(currentListSize: count)
                                                }
                                                
                                        }.onTapGesture {
                                            self.bigPictureId = imageItem.id
                                            self.bigPicture = imageItem.image
                                            self.showSheet = true
                                            self.showBigPicture = true
                                        }
                                    }
                                    
                                }
                            }
                        }.padding(EdgeInsets.init(top: 0, leading: -20, bottom: 0, trailing: -20))
                    }
                    if selectorIndex == 1 {
                        MapView(coordinate: CLLocationCoordinate2D(
                            latitude: 1,
                            longitude: 1))
                    }
                }.padding(.init(top: -15, leading: 0, bottom: 0, trailing: 0))
            }
            
        }.onAppear(){
            self.ViewModel = PicScapeMeViewModel(login: self.loginData, loading: self.loadingData, error: self.errorData, user: self.userData)
            self.ViewModel.viewUpdate = self
            if(self.tempList.array.count == 0){
                self.ViewModel.getNewItems(currentListSize: 0)
            }
            UITableView.appearance().separatorColor = .clear
            if let temp = PicScapeImageStorage.Find(key: self.userData.UserData.Username, type: EStorageType.Profile_Picture){
                self.UserPicture = Image(uiImage: temp)
            }
        }
        .sheet(isPresented: $showSheet, onDismiss: self.closeSheet){
            if self.showImagePicker == true{
                ImagePicker(isVisibile: self.$showImagePicker, image: self.$image , sourceType: 1).edgesIgnoringSafeArea(.bottom)
                    .onDisappear(){
                        self.uploadPicture()
                }.onAppear(){
                    self.image = UIImage()
                }
            }
            if self.showSettings == true {
                PicScapeSettingsView()
                    .environmentObject(self.errorData)
                    .environmentObject(self.loadingData)
                    .environmentObject(self.userData)
                    .environmentObject(self.loginData)
            }
            if self.showUploadPhoto == true {
                UploadPictureView()
                    .environmentObject(self.errorData)
                    .environmentObject(self.loadingData)
                    .environmentObject(self.userData)
            }
            
            if self.showBigPicture == true {
                SinglePictureView(image: self.bigPicture!, id: self.bigPictureId)
                    .environmentObject(self.errorData)
                    .environmentObject(self.loadingData)
            }
        }
        
    }
    
    func closeSheet() {
        self.showImagePicker = false
        self.showSettings = false
        self.showBigPicture = false
        self.showUploadPhoto = false
    }
    
    func uploadPicture(){
        ViewModel.UploadPicture(selectedImage: self.image)
    }
    
    func modeImagePicker(){
        self.showSheet = true
        showImagePicker = !showImagePicker
    }
    
    func modeSettings() {
        debugPrint("Test")
        self.showSheet = true
        showSettings = !showSettings
    }
    
    func modeUploadPhoto() {
        self.showSheet = true
        showUploadPhoto = !showUploadPhoto
    }
}

extension PicScapeMeView: ViewUpdateProtocol{
    func appendData(list: [PictureListModel]?) {
        self.tempList.array.append(contentsOf: list!)
        var tempList : [[PictureListModel]] = [[PictureListModel]]()
        var _ =  list!.publisher.collect(2).collect().sink(receiveValue: {tempList = $0})
        self.showList.append(contentsOf: tempList)
    }
}

protocol ViewUpdateProtocol{
    func appendData(list: [PictureListModel]?)
}

struct PicScapeMeView_Previews: PreviewProvider {
    static var previews: some View {
        PicScapeMeView()
            .environmentObject(UserBinding())
            .environmentObject(LoginBinding())
            .environmentObject(ErrorBinding())
            .environmentObject(LoadingBinding())
    }
}
