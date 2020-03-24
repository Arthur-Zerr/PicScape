//
//  ImageCache.swift
//  PicScape
//
//  Created by Arthur Zerr on 16.03.20.
//  Copyright © 2020 ArthurZerr. All rights reserved.
//

import Foundation
import UIKit

public class PicScapeImageCache : PicScapeCache{
    typealias T = UIImage
    
    static var imageCache = NSCache<NSString, UIImage>()
    
    /**
     Adds the Image with the corresponding Key to the Cache
     */
    static func Add(key: String, type: ECacheTypes, item: UIImage) -> Bool {
        if let _ = imageCache.object(forKey: GetKey(key: key, type: type)){
            return false
        }
        imageCache.setObject(item, forKey: GetKey(key: key, type: type))
        return true
    }
    
    /**
     Updates the Image with the new image
     */
    static func Update(key: String, type: ECacheTypes, item: UIImage) -> Bool {
        if let _ = imageCache.object(forKey: GetKey(key: key, type: type)){
            return false
        }
        
        if Remove(key: key, type: type) == true {
            imageCache.setObject(item, forKey: GetKey(key: key, type: type))
            return true
        }
        
        return false
    }
    
    /**
     Removes  the Image with the corresponding Key from the Cache
     */
    static func Remove(key: String, type: ECacheTypes) -> Bool {
        if let _ = imageCache.object(forKey: GetKey(key: key, type: type)){
            imageCache.removeObject(forKey: GetKey(key: key, type: type))
            return true
        }
        return false
    }
    
    /**
     Removes all Images from the Cache
     */
    static func RemoveAll() {
        imageCache.removeAllObjects()
    }
    
    /**
     Find  the Image with the corresponding Key in the Cache
     */
    static func Find(key: String, type: ECacheTypes) -> UIImage? {
        if let temp = imageCache.object(forKey: GetKey(key: key, type: type)){
            return temp
        }
        return nil
    }
    
    /**
     Generates  the key from the key and the cache type
     */
    static func GetKey(key : String, type : ECacheTypes) -> NSString{
        return key.lowercased() + "_" + type.rawValue as NSString
    }
}
