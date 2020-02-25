//
//  JwtToken.swift
//  PicScape
//
//  Created by Arthur Zerr on 05.01.20.
//  Copyright © 2020 ArthurZerr. All rights reserved.
//

import Foundation
import Alamofire

public class JwtTokenInterceptor: RequestInterceptor {

    var token : String = ""
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void){
        var modifiedURLRequest = urlRequest
        token = PicScapeKeychain.GetAPIToken()
        modifiedURLRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        completion(.success(modifiedURLRequest))
    }

     public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 {
            token = PicScapeKeychain.GetAPIToken()
        }
        completion(.retry)
    }
}

