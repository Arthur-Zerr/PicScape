//
//  PicScapeData.swift
//  PicScape
//
//  Created by Arthur Zerr on 14.10.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import Foundation

var PicScapeData: [Picture_Component_Model] {
    get {
        if cachedPictureData.count <= 0 {
            cachedPictureData = loadData()
        }
        return cachedPictureData
    }
    set {}
}

private var cachedPictureData: [Picture_Component_Model] = []

private func loadData() -> [Picture_Component_Model]{
    let rawData : [Picture_Component_Model] = Json.load("userData.json")
    
    return rawData
}


var PicScapeNewData: [Picture_Model] {
    get {
        if cachedPicScapeNewData.count <= 0 {
            cachedPicScapeNewData = loadNewData()
        }
        return cachedPicScapeNewData
    }
    set {}
}

private var cachedPicScapeNewData: [Picture_Model] = []

private func loadNewData() -> [Picture_Model]{
    let rawData : [Picture_Model] = Json.load("picture.json")
    
    return rawData
}


