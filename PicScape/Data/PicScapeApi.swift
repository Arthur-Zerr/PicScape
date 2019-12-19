//
//  PicScapeApi.swift
//  PicScape
//
//  Created by Arthur Zerr on 18.11.19.
//  Copyright © 2019 ArthurZerr. All rights reserved.
//

import Alamofire


public class PicScapeAPI {
    static var url : String = "http://192.168.178.96:5000"
    
    static func sendGet(){


    }
    static func Login(username : String, password : String, completion: @escaping (Result<ResponseDto, AFError>) -> Void) {
        let login = UserForLoginDto(Username: username, Password: password)
        
        AF.request(url + "/Auth/Login",
                       method: .post,
                       parameters: login,
                       encoder: JSONParameterEncoder.default).responseDecodable(completionHandler:{ (response: DataResponse<ResponseDto, AFError>) in
                        completion(response.result)
                })
    }
    
    static func getIsOnline() -> Bool {
//        let request = RestRequest(method: .get, url: url + "/api/User/IsOnline")
//        var onlineResult : Bool = false
//
//        let syncConc = DispatchQueue(label:"con",attributes:.concurrent)
//        let group = DispatchGroup()
//        group.enter()
//        syncConc.sync  {
//            request.responseVoid{ result in
//                switch result {
//                case .success( _):
//                        onlineResult = true
//                        break
//                case .failure( let error):
//                    print(error)
//                    onlineResult = false
//                    break
//                }
//            }
//            group.leave()
//        }
//        group.notify(queue: syncConc)
//        {
//            return onlineResult
//        }
        return false
    }
    
    
    static func getImageWithId(id : Int){
//        let request = RestRequest(method: .get, url: url  + "/api/Picture/Picture")
//
//        request.responseData { result in
//            switch result {
//            case .success(_):
//                break
//            case .failure(let error):
//                print(error)
//            }
//        }
        
    }
}

