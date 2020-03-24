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
//        static var url : String = "http://192.168.64.106:5000"
    
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
    static func GetUserDataByName(username : String, completion: @escaping (Result<ResponseDto, AFError>) -> Void) {
        let Param  = [
            "name": username
        ]
        
        PicScapeApiSession.request(url + "/User/UserDataByName=" + username,
                                   method: .get,
                                   parameters: Param,
                                   encoder: URLEncodedFormParameterEncoder.default).responseDecodable(completionHandler:{ (response: DataResponse<ResponseDto, AFError>) in
                                    completion(response.result)
                                   })
    }
    
    static func GetUserDataById(userId : String, completion: @escaping (Result<ResponseDto, AFError>) -> Void) {
        let Param  = [
            "id": userId
        ]
        
        PicScapeApiSession.request(url + "/User/UserDataById=" + userId,
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
    
    static func GetPictureData(Id : Int, completion: @escaping (Result<PictureDataDto, AFError>) -> Void) {
        let Param = ["id" : Id]
        PicScapeApiSession.request(url + "/Picture/PictureData",
                                   method: .get,
                                   parameters: Param,
                                   encoder: URLEncodedFormParameterEncoder.default
        ).responseDecodable(completionHandler:{ (response: DataResponse<PictureDataDto, AFError>) in
            completion(response.result)
        })
    }
    
    static func GetPicturesForUser(username: String, Page : Int, completion: @escaping (Result<[PictureModel], AFError>) -> Void) {
        let Param = ["Username" : username, "page" : String(Page), "pageSize" : "15"]
        
        PicScapeApiSession.request(url + "/Picture/AllPictureForUser",
                                   method: .get,
                                   parameters: Param,
                                   encoder: URLEncodedFormParameterEncoder.default
        ).responseDecodable(completionHandler:{ (response: DataResponse<[PictureModel], AFError>) in
            completion(response.result)
        })
    }
    
    static func UploadProfilePicture(Picture: UIImage, completion: @escaping (Result<ResponseDto, AFError>) -> Void) {
        let imgData = Picture.jpegData(compressionQuality: 75)
        
        PicScapeApiSession.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData!, withName: "file",fileName: "file.jpeg", mimeType: "image/jpeg")
        },to: url + "/Picture/ProfilePicture").responseDecodable(completionHandler:{ (response: DataResponse<ResponseDto, AFError>) in
            completion(response.result)
        })
    }
    
    static func UploadPicture(Picture: UIImage, completion: @escaping (Result<ResponseDto, AFError>) -> Void) {
        let imgData = Picture.jpegData(compressionQuality: 90)
        
        PicScapeApiSession.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData!, withName: "file",fileName: "file.jpeg", mimeType: "image/jpeg")
        },to: url + "/Picture/Picture").responseDecodable(completionHandler:{ (response: DataResponse<ResponseDto, AFError>) in
            completion(response.result)
        })
    }
    

}
