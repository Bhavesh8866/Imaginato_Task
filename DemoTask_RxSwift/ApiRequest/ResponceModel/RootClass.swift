//
//  RootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on December 16, 2020

import Foundation


class RootClass : NSObject, NSCoding{

    var data : Datum!
    var errorMessage : String!
    var result : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        errorMessage = dictionary["error_message"] as? String
        result = dictionary["result"] as? Int
        if let dataData = dictionary["data"] as? [String:Any]{
            data = Datum(fromDictionary: dataData)
        }
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if errorMessage != nil{
            dictionary["error_message"] = errorMessage
        }
        if result != nil{
            dictionary["result"] = result
        }
        if data != nil{
            dictionary["data"] = data.toDictionary()
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        data = aDecoder.decodeObject(forKey: "data") as? Datum
        errorMessage = aDecoder.decodeObject(forKey: "error_message") as? String
        result = aDecoder.decodeObject(forKey: "result") as? Int
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if data != nil{
            aCoder.encode(data, forKey: "data")
        }
        if errorMessage != nil{
            aCoder.encode(errorMessage, forKey: "error_message")
        }
        if result != nil{
            aCoder.encode(result, forKey: "result")
        }
    }
}