//
//  UserDB.swift
//  DemoTask_RxSwift
//
//  Created by rlogical-dev-59 on 16/12/20.
//

import UIKit
import Foundation
import RealmSwift


func UniquePrimeryKey(_ userId: String) -> String {
    return (userId)
}


class UserDB: Object
{
    @objc dynamic var createdAt : String!
    @objc dynamic var userId : String!
    @objc dynamic var userName : String!
    
    override static func primaryKey() -> String? {
        return "userId"
    }

    
    convenience init (createdAt: String, userId: String, userName: String)
    {
        self.init()
        
        self.createdAt = createdAt
        self.userId = userId
        self.userName = userName
    }
    
}

