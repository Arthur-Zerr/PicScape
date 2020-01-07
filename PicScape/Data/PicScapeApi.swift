//
//  PicScapeApi.swift
//  PicScape
//
//  Created by Arthur Zerr on 18.11.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import Alamofire
import Foundation

public class PicScapeAPI: NSObject{
    static var url : String = "http://192.168.178.96:5000"
    static var PicScapeApiSession = Session(configuration: URLSessionConfiguration.default,interceptor: JwtTokenInterceptor())
    
    // MARK: - Auth
    static func Login(loginData : UserForLoginDto, completion: @escaping (Result<ResponseDto, AFError>) -> Void) {
        AF.request(url + "/Auth/Login",
                   method: .post,
                   parameters: loginData,
                   encoder: JSONParameterEncoder.default).responseDecodable(completionHandler:{ (response: DataResponse<ResponseDto, AFError>) in
                    completion(response.result)
                   })
    }
    
    static func Register(registerData : UserForRegisterDto, completion: @escaping (Result<ResponseDto, AFError>) -> Void) {
        AF.request(url + "/Auth/Register",
                   method: .post,
                   parameters: registerData,
                   encoder: JSONParameterEncoder.default).responseDecodable(completionHandler:{ (response: DataResponse<ResponseDto, AFError>) in
                    completion(response.result)
                   })
    }
    
    // MARK: - User
    static func GetUserData(userId : String, completion: @escaping (Result<ResponseDto, AFError>) -> Void) {
        let Param  = [
            "id": userId
        ]
        
        PicScapeApiSession.request(url + "/User/UserData",
                   method: .get,
                   parameters: Param,
                   encoder: URLEncodedFormParameterEncoder.default).responseDecodable(completionHandler:{ (response: DataResponse<ResponseDto, AFError>) in
                    completion(response.result)
                   })
    }
    
    // MARK: - Testing
    static func IsOnline(completion: @escaping (Result<ResponseDto, AFError>) -> Void) {
        let Param = ["" : ""]
        let jwtHeader : HTTPHeader = HTTPHeader.authorization(bearerToken: PicScapeKeychain.GetAPIToken())
        let authHeaders = HTTPHeaders(arrayLiteral: jwtHeader)
        
        PicScapeApiSession.request(url + "/User/IsOnline",
                   method: .get,
                   parameters: Param,
                   encoder: URLEncodedFormParameterEncoder.default
//                   headers: authHeaders
        ).responseDecodable(completionHandler:{ (response: DataResponse<ResponseDto, AFError>) in
                    completion(response.result)
            })
    }
}
