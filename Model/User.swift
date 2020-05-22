//
//  User.swift
//  FingerDrum
//
//  Created by Mac on 3/30/20.
//  Copyright © 2020 esprit. All rights reserved.
//

import Foundation

class User  {
    
    var id : Int?
    var first_name : String?
    var last_name : String?
    var email : String?
    var password : String?
    var image : String?
    var username : String?
    var phone : Int?
    var role : Int?
    var country : String?
    
    
    
    struct UserKeys {
    
    static let id = "id"
    static let first_name = "first_name"
    static let last_name = "last_name"
    static let email = "email"
    static let password = "password"
    static let image = "image"
    static let username = "username"
    static let phone = "phone"
    static let role = "role"
    static let country = "country"
    
    }
    
    init(UserDictionary : [String : Any]) {
        
        id = UserDictionary[UserKeys.id] as? Int
        first_name = UserDictionary[UserKeys.first_name] as? String
        last_name = UserDictionary[UserKeys.last_name] as? String
        email = UserDictionary[UserKeys.email] as? String
        password = UserDictionary[UserKeys.password] as? String
        image = UserDictionary[UserKeys.first_name] as? String
        username = UserDictionary[UserKeys.username] as? String
        phone = UserDictionary[UserKeys.phone] as? Int
        role = UserDictionary[UserKeys.role] as? Int
        country = UserDictionary[UserKeys.country] as? String

    }
    
    
}



