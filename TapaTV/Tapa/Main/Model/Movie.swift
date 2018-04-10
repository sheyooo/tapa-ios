//
//  Movie.swift
//  TapaTV
//
//  Created by SimpuMind on 4/7/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import Foundation

class Movie: NSObject, JSONDecodable {
    
    var id = String()
    var updatedAt = String()
    var createdAt = String()
    var title = String()
    var contentDescription = String()
    var posterImageUrl = String()
    var releaseDate = String()
    var video: Video?
    var _genre = [Any]()
    var _tags = [Any]()
    var type = String()
    
    
    required init?(_ json: [String : Any]) {
        self.id = json["_id"] as? String ?? ""
        self.updatedAt = json["updatedAt"] as? String ?? ""
        self.title = json["title"] as? String ?? ""
        self.contentDescription = json["description"] as? String ?? ""
        self.posterImageUrl = json["posterImageUrl"] as? String ?? ""
        //self.releaseDate = json["releaseDate"] as? String ?? ""
        if let video = json["_video"] as? [String: Any] {
            self.video = Video(video)
        }
    }
    
}

class Video: NSObject, JSONDecodable {
    
    var id = String()
    var updatedAt = String()
    var createdAt = String()
    var title = String()
    var videoUrl = String()
    var _data  = String()
    var type = String()
    
    required init?(_ json: [String : Any]) {
        self.id = json["_id"] as? String ?? ""
        self.updatedAt = json["updatedAt"] as? String ?? ""
        self.title = json["title"] as? String ?? ""
        self.createdAt = json["createdAt"] as? String ?? ""
        self.videoUrl = json["videoUrl"] as? String ?? ""
        self._data = json["_data"] as? String ?? ""
        self.type = json["type"] as? String ?? ""
    }
}
