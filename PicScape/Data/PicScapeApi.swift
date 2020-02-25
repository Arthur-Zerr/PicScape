//
//  PicScapeApi.swift
//  PicScape
//
//  Created by Arthur Zerr on 18.11.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import Alamofire
import AlamofireImage
import Foundation
import UIKit

public class PicScapeAPI: NSObject{
//    static var url : String = "http://192.168.178.96:5000"
    static var url : String = "http://localhost:5000"
//    static var url : String = "http://192.168.64.106:5000"
    
    static var PicScapeApiSession = Session(configuration: URLSessionConfiguration.default, interceptor: JwtTokenInterceptor())
    
    // MARK: - Auth
    static func Login(loginData : UserForLoginDto, completion: @escaping (Result<ResponseDto, AFError>) -> Void) {
        AF.request(url + "/Auth/Login",
                   method: .post,
                   parameters: loginData,
                   encoder: JSONParameterEncoder.default).responseDecodable(completionHandler:{ (response: DataResponse<ResponseDto, AFError>) in
                    completion(response.result)
                   })
    }
    
    static func Logout(logoutData : UserForLogoutDto, completion: @escaping (Result<ResponseDto, AFError>) -> Void) {
        PicScapeApiSession.request(url + "/Auth/Logout",
                                   method: .post,
                                   parameters: logoutData,
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
            "name": userId
        ]
        
        PicScapeApiSession.request(url + "/User/name=" + userId,
                                   method: .get,
                                   parameters: Param,
                                   encoder: URLEncodedFormParameterEncoder.default).responseDecodable(completionHandler:{ (response: DataResponse<ResponseDto, AFError>) in
                                    completion(response.result)
                                   })
    }
    
    static func UpdateUserData(userForUpdate : UserForUpdateDto, completion: @escaping (Result<ResponseDto, AFError>) -> Void) {
        PicScapeApiSession.request(url + "/User/UpdateUserData",
                   method: .post,
                   parameters: userForUpdate,
                   encoder: JSONParameterEncoder.default).responseDecodable(completionHandler:{ (response: DataResponse<ResponseDto, AFError>) in
                    completion(response.result)
                   })
    }
    
    // MARK: - Testing
    static func IsOnline(completion: @escaping (Result<ResponseDto, AFError>) -> Void) {
        let Param = ["" : ""]
        
        PicScapeApiSession.request(url + "/User/IsOnline",
                                   method: .get,
                                   parameters: Param,
                                   encoder: URLEncodedFormParameterEncoder.default
        ).responseDecodable(completionHandler:{ (response: DataResponse<ResponseDto, AFError>) in
            completion(response.result)
        })
    }
    
    // MARK: - Picture
    static func GetPicture(completion: @escaping (Result<Image, AFError>) -> Void) {
        PicScapeApiSession.request(url + "/Picture"
        ).responseImage(completionHandler:{ response in
            completion(response.result)
        })
    }
    
    static func GetProfilePicture(Username: String, completion: @escaping (Result<Image, AFError>) -> Void) {
        let Param = ["Username" : Username]
        PicScapeApiSession.request(url + "/Picture/ProfilePicture",
                                   method: .get,
                                   parameters: Param,
                                   encoder: URLEncodedFormParameterEncoder.default
        ).responseImage(completionHandler:{ response in
            completion(response.result)
        })
    }
    
    static func UploadProfilePicture(Picture: UIImage, completion: @escaping (Result<ResponseDto, AFError>) -> Void) {
        let imgData = Picture.jpegData(compressionQuality: 90)

        PicScapeApiSession.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(imgData!, withName: "file",fileName: "file.jpg", mimeType: "image/jpg")
            },to: url + "/Picture/ProfilePicture").responseDecodable(completionHandler:{ (response: DataResponse<ResponseDto, AFError>) in
                completion(response.result)
            })
    }
}
