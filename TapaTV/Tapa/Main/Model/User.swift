//
//  User.swift
//  TapaTV
//
//  Created by SimpuMind on 3/25/18.
//  Copyright © 2018 SimpuMind. All rights reserved.
//

import Foundation

public class User: NSObject, NSCoding, JSONDecodable  {
    
    var id = String()
    var updatedAt = String()
    var createdAt = String()
    var name = String()
    var email = String()
    var role = String()
    var __v = Int()
    var deleted = Bool()
    var stripeSubscription = Bool()
    var canWatch = Bool()
    
    required public init?(_ json: [String : Any]) {
        self.id = json["_id"] as? String ?? ""
        self.updatedAt = json["updatedAt"] as? String ?? ""
        self.createdAt = json["createdAt"] as? String ?? ""
        self.name = json["name"] as? String ?? ""
        self.email = json["email"] as? String ?? ""
        self.role = json["role"] as? String ?? ""
        self.__v = json["__v"] as? Int ?? 0
        self.deleted = json["deleted"] as? Bool ?? false
        self.stripeSubscription = json["stripeSubscription"] as? Bool ?? false
        self.canWatch = json["canWatch"] as? Bool ?? false
    }
    
    required public init(id: String, updatedAt: String,
         createdAt: String, name: String,
         email: String, role: String, __v: Int, deleted: Bool, stripeSubscription: Bool, canWatch: Bool) {
        self.id = id
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.name = name
        self.email = email
        self.role = role
        self.__v = __v
        self.deleted = deleted
        self.stripeSubscription = stripeSubscription
        self.canWatch = canWatch
        super.init()
    }
    
    required public init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as! String
        self.createdAt = aDecoder.decodeObject(forKey: "createdAt") as! String
        //self.updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as! String
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.email = aDecoder.decodeObject(forKey: "email") as! String
        self.role = aDecoder.decodeObject(forKey: "role") as! String
        //self.__v = aDecoder.decodeObject(forKey: "__v") as! Int
        self.deleted = aDecoder.decodeBool(forKey: "deleted")
        self.stripeSubscription = aDecoder.decodeBool(forKey: "stripeSubscription")
        self.canWatch = aDecoder.decodeBool(forKey: "canWatch")
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.createdAt, forKey: "createdAt")
        aCoder.encode(self.updatedAt, forKey: "updateAt")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.email, forKey: "email")
        aCoder.encode(self.role, forKey: "role")
        aCoder.encode(self.__v, forKey: "__v")
        aCoder.encode(self.deleted, forKey: "deleted")
        aCoder.encode(self.stripeSubscription, forKey: "stripeSubscription")
        aCoder.encode(self.canWatch, forKey: "canWatch")
    }
    
    public func dictionaryRepresentation() -> [String: Any] {
        return [
            "id": self.id,
            "createdAt": self.createdAt,
            "updatedAt": self.updatedAt,
            "name": self.name,
            "email": self.email,
            "role": self.role,
            "__v": self.__v,
            "deleted": self.deleted,
            "stripeSubscription": self.stripeSubscription,
            "canWatch": self.canWatch
        ]
    }
}
