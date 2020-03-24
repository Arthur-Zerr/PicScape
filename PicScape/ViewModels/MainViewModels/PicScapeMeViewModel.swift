//
//  PicScapeMeViewModel.swift
//  PicScape
//
//  Created by Arthur Zerr on 18.02.20.
//  Copyright © 2020 ArthurZerr. All rights reserved.
//

import Foundation
import SwiftUI
import AlamofireImage
import RxSwift

extension PicScapeMeView {
    class PicScapeMeViewModel : ObservableObject{
        
        private var loginData : LoginBinding = LoginBinding()
        private var errorData : ErrorBinding = ErrorBinding()
        private var loadingData : LoadingBinding = LoadingBinding()
        private var userData : UserBinding = UserBinding()
        
        private let meInfiniteScrollRepository : MeInfiniteScrollRepository = MeInfiniteScrollRepository()
        public var viewUpdate: ViewUpdateProtocol? = nil
        private let disposeBag = DisposeBag()
        
        init() {}
        
        init(login: LoginBinding, loading: LoadingBinding, error: ErrorBinding, user: UserBinding) {
            self.loginData = login
            self.loadingData = loading
            self.errorData = error
            self.userData = user
            
            self.meInfiniteScrollRepository.getPictureModelArray().subscribe({ [weak self] newList in
                self?.updateListItems(newList: newList.element)
            }).disposed(by: disposeBag)
        }
        
        func updateListItems(newList: [PictureListModel]?){
            if newList != nil && !newList!.isEmpty{
                self.viewUpdate?.appendData(list: newList)
            }
        }
        
        func getNewItems(currentListSize: Int){
            meInfiniteScrollRepository.fetchListItems(currentListSize: currentListSize, Username: self.userData.UserData.Username)
            
        }
        
        func UploadPicture(selectedImage : UIImage?){
            if(selectedImage?.cgImage == nil){
                return
            }
            
            self.loadingData.Loading = true
            let image : UIImage = selectedImage ?? UIImage()
            PicScapeAPI.UploadProfilePicture(Picture: image){ result in
                switch result {
                case .success(let responseData):
                    if responseData.success == true {
                        self.loadingData.Loading = false
                    }
                    else {
                        self.errorData.ShowError(message : responseData.message)
                        self.loadingData.Loading = false
                    }
                case .failure(let error):
                    self.errorData.ShowError(message : error.localizedDescription)
                    self.loadingData.Loading = false
                }
            }
        }
        
        func doNothing(){}
    }
}
