//
//  PicScapeStorage.swift
//  PicScape
//
//  Created by Arthur Zerr on 04.01.20.
//  Copyright © 2020 ArthurZerr. All rights reserved.
//

import Foundation

public class PicScapeKeychain{
       
    // MARK: - User Storage
    static func SaveUserData(Username: String, Password: String){
        let usernameSuccesfull: Bool = KeychainWrapper.standard.set(Username, forKey: "Username", withAccessibility: .always)
        if !usernameSuccesfull {
            print("Error Saving Username in KeyChain")
        }
        
        let passwordSuccesfull: Bool = KeychainWrapper.standard.set(Password, forKey: "Password", withAccessibility: .always)
        if !passwordSuccesfull {
            print("Error Saving Password in KeyChain")
        }
    }
    
    static func GetUserUsername() -> String {
        let retrievedString: String? = KeychainWrapper.standard.string(forKey: "Username")
        return retrievedString ?? ""
    }
    
    static func GetUserPassword() -> String {
        let retrievedString: String? = KeychainWrapper.standard.string(forKey: "Password")
        return retrievedString ?? ""
    }
    
    static func HasUserData() -> Bool {
        if GetUserUsername() != "" && GetUserPassword() != ""{
            return true
        }
        return false
    }
    
    static func RemoveUserData(){
        KeychainWrapper.standard.removeObject(forKey: "Username")
        KeychainWrapper.standard.removeObject(forKey: "Password")
    }
    
    // MARK: - API Storage
    static func SaveAPIToken(Token: String){
        let tokenSuccesfull: Bool = KeychainWrapper.standard.set(Token, forKey: "APIToken", withAccessibility: .always)
        if !tokenSuccesfull {
            print("Error Saving Token in KeyChain")
        }
    }
    
    static func GetAPIToken() -> String {
        let retrievedString: String? = KeychainWrapper.standard.string(forKey: "APIToken")
        return retrievedString ?? ""
    }
    
    static func RemoveAPIToken(){
        KeychainWrapper.standard.removeObject(forKey: "APIToken")
    }
}
