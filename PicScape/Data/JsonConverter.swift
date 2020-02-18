//
//  JsonConverter.swift
//  PicScape
//
//  Created by Arthur Zerr on 23.01.20.
//  Copyright © 2020 ArthurZerr. All rights reserved.
//

import Foundation

class JsonConverter {
    static func convert<T: Codable>(jsonString : String, as type: T.Type = T.self) -> T {
        let data = Data(jsonString.utf8)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(T.self):\n\(error)")
        }
    }
    
}
