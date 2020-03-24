//
//  MeInfiniteScrollRepository.swift
//  PicScape
//
//  Created by Arthur Zerr on 28.02.20.
//  Copyright © 2020 ArthurZerr. All rights reserved.
//

import Foundation
import RxSwift
import SwiftUI

class MeInfiniteScrollRepository : InfiniteScrollRepoProtocol{
    // this is an observable which holds our data
    private let listObservable = BehaviorSubject<[PictureListModel]>(value: [])
    
    func getPictureModelArray() -> BehaviorSubject<[PictureListModel]>{
        return listObservable
    }

        
    func fetchListItems(currentListSize: Int, Username: String){
        let limit = 15
        let currentPage = currentListSize * 3
        let page = currentPage/limit + 1
        
        debugPrint("curentpage: " + String(currentPage) + "page: " + String(page))
        
        PicScapeAPI.GetPicturesForUser(username: Username, Page: page) { result in
            switch result {
            case .success(let responseData):
                self.listObservable.onNext(self.ConvertList(list: responseData))
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func ConvertList(list : [PictureModel]) -> [PictureListModel]{
        var tempList : [PictureListModel] = [PictureListModel]()
        let _ = list.map{tempList.append(PictureListModel(id: $0.id, image: UIImage(data: Data(base64Encoded: $0.img)!)!))}
        
        return tempList
    }
  
}
