//
//  PicScapeCache.swift
//  PicScape
//
//  Created by Arthur Zerr on 16.03.20.
//  Copyright © 2020 ArthurZerr. All rights reserved.
//

import Foundation
import UIKit


protocol PicScapeCache {
    associatedtype T
    
    static func Add(key : String, type : ECacheTypes, item : T) -> Bool
    
    static func Update(key : String, type : ECacheTypes, item : T) -> Bool
    
    static func Remove(key : String, type : ECacheTypes) -> Bool
    
    static func RemoveAll()
    
    static func Find(key : String, type : ECacheTypes) -> T?
    
    static func GetKey(key : String, type : ECacheTypes) -> NSString
    
}
