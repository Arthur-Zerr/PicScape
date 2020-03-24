//
//  InfiniteScrollRepoProtocol.swift
//  PicScape
//
//  Created by Arthur Zerr on 28.02.20.
//  Copyright © 2020 ArthurZerr. All rights reserved.
//

import Foundation
import RxSwift

protocol InfiniteScrollRepoProtocol{
    
    func getPictureModelArray() -> BehaviorSubject<[PictureListModel]>
    func fetchListItems(currentListSize: Int, Username: String)
    
}
