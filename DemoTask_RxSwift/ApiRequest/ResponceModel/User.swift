//
//  User.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on December 16, 2020

import Foundation


class User : NSObject, NSCoding{

    var createdAt : String!
    var userId : Int!
    var userName : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        createdAt = dictionary["created_at"] as? String
        userId = dictionary["userId"] as? Int
        userName = dictionary["userName"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if userId != nil{
            dictionary["userId"] = userId
        }
        if userName != nil{
            dictionary["userName"] = userName
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
        userId = aDecoder.decodeObject(forKey: "userId") as? Int
        userName = aDecoder.decodeObject(forKey: "userName") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "userId")
        }
        if userName != nil{
            aCoder.encode(userName, forKey: "userName")
        }
    }
}