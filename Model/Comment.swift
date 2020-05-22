//
//  Comment.swift
//  Utgd
//
//  Created by Mac on 12/10/18.
//  Copyright © 2018 esprit. All rights reserved.
//

import Foundation
class Comment  {
    var id : Int?
    var id_user : Int?
    var id_work : Int?
    var content: String?
    var date: String?
    var username: String?
    
    
    
    struct  CommentKeys {
        static let id  = "id"
        static let id_user = "id_user"
        static let id_work = "id_work"
        static let content = "content"
        static let date = "date"
        static let username = "username"
    }
    
    init(CommentDictionary : [String : Any]) {
        
        id = CommentDictionary[CommentKeys.id] as? Int
        id_user = CommentDictionary[CommentKeys.id_user] as? Int
        id_work = CommentDictionary[CommentKeys.id_work] as? Int
        content = CommentDictionary[CommentKeys.content] as? String
        date = CommentDictionary[CommentKeys.date] as? String
        username = CommentDictionary[CommentKeys.username] as? String
        
        
    }
    
    
    
}
