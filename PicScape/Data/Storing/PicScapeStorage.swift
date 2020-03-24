//
//  PicScapeStorage.swift
//  PicScape
//
//  Created by Arthur Zerr on 18.03.20.
//  Copyright © 2020 ArthurZerr. All rights reserved.
//

import Foundation

protocol PicScapeStorage {
    associatedtype T
    
    static func Add(key : String, type : EStorageType, item : T) -> Bool
    
    static func Update(key : String, type : EStorageType, item : T) -> Bool
    
    static func AddOrUpdate(key : String, type : EStorageType, item : T) -> Bool
    
    static func Remove(key : String, type : EStorageType) -> Bool
    
    static func RemoveAll()
    
    static func Find(key : String, type : EStorageType) -> T?
    
    static func GetFilePath(key : String , type: EStorageType) -> URL?
    
    static func Getkey(key : String, type : EStorageType) -> NSString
}
