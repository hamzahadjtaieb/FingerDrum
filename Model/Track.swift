//
//  Track.swift
//  FingerDrum
//
//  Created by Mac on 4/1/20.
//  Copyright © 2020 esprit. All rights reserved.
//

import Foundation


class Track  {
    
    var id : Int?
    var id_user : Int?
    var image : String?
    var auteur : String?
    var title : String?
    var genre : String?
    var prix : Int?
    var nbr_like : Int?
    var nbr_cmnt : Int?
    
    
    
    
    
    //JSON KEY
    struct TrackKeys {
        
        static let id = "id"
        static let id_user = "id_user"
        static let image = "image"
        static let auteur = "auteur"
        static let title = "title"
        static let genre = "genre"
        static let prix = "prix"
        static let nbr_like = "nbr_like"
        static let nbr_cmnt = "nbr_cmnt"
        
    }
    
    
    //
    init(TrackDictionary : [String : Any]) {
        
        id = TrackDictionary[TrackKeys.id] as? Int
        id_user = TrackDictionary[TrackKeys.id_user] as? Int
        image = TrackDictionary[TrackKeys.image] as? String
        auteur = TrackDictionary[TrackKeys.auteur] as? String
        title = TrackDictionary[TrackKeys.title] as? String
        genre = TrackDictionary[TrackKeys.genre] as? String
        prix = TrackDictionary[TrackKeys.prix] as? Int
        nbr_like = TrackDictionary[TrackKeys.nbr_like] as? Int
        nbr_cmnt = TrackDictionary[TrackKeys.nbr_cmnt] as? Int
        
        
    }
    
    
}
