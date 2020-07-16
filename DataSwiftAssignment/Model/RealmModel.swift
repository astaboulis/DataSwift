//
//  RealmModel.swift
//  DataSwiftAssignment
//
//  Created by Angelos Staboulis on 13/7/20.
//  Copyright © 2020 Angelos Staboulis. All rights reserved.
//

import Foundation
import RealmSwift

class RealmModel:Object{
    @objc dynamic var id=0
    @objc dynamic var poster = ""
    @objc dynamic var title = ""
    
    convenience init(id:Int,poster:String,title:String){
        self.init()
        self.id = id
        self.title = title
        self.poster = poster
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
