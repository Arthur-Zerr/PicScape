//
//  PicScapeImageStorage.swift
//  PicScape
//
//  Created by Arthur Zerr on 18.03.20.
//  Copyright © 2020 ArthurZerr. All rights reserved.
//

import Foundation
import UIKit

public class PicScapeImageStorage : PicScapeStorage{
    typealias T = UIImage
    
    static func Add(key: String, type: EStorageType, item: UIImage) -> Bool {
        if let _ = Find(key: key, type: type){
            return false
        }
        
        if let pngRepresentation = item.pngData() {
            if let filePath = GetFilePath(key: key, type: type) {
                do  {
                    try pngRepresentation.write(to: filePath,
                                                options: .atomic)
                    return true
                } catch let error {
                    print("Saving file resulted in error: ", error)
                    return false
                }
            }
        }
        return false
    }
    
    static func Update(key: String, type: EStorageType, item: UIImage) -> Bool {
        if let _ = Find(key: key, type: type){
            return false
        }
        if Remove(key: key, type: type){
            if Add(key: key, type: type, item: item){
                return true
            }
            
        }
        return false
    }
    
    static func AddOrUpdate(key : String, type : EStorageType, item : UIImage) -> Bool{
        if let _ = Find(key: key, type: type){
            if Update(key: key, type: type, item: item){
                return true
            }
        }
        if Add(key: key, type: type, item: item){
            return true
        }
        
        return false
    }
    
    static func Remove(key: String, type: EStorageType) -> Bool {
        if let _ = Find(key: key, type: type){
            return false
        }
        
        if let filePath = GetFilePath(key: key, type: type){
            do{
                try FileManager.default.removeItem(at: filePath)
                return true
            } catch let error{
                print("removing file resulted in error: ", error)
                return false
            }
        }
        return false
    }
    
    static func RemoveAll() {
    }
    
    static func Find(key: String, type: EStorageType) -> UIImage? {
        if let filePath = GetFilePath(key: key, type: type){
            if let tempdata = FileManager.default.contents(atPath: filePath.path){
                return UIImage(data: tempdata)
            }
            return nil
        }
        return nil
    }
    
    static func GetFilePath(key : String , type: EStorageType) -> URL? {
        let fileManager = FileManager.default
        let filename = Getkey(key: key, type: type)
        
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                 in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        
        return documentURL.appendingPathComponent(filename as String + ".png")
        
    }
    
    static func Getkey(key: String, type: EStorageType) -> NSString {
        return key.lowercased() + "_" + type.rawValue as NSString
    }
}
