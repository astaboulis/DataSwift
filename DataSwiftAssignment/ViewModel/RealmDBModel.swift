//
//  RealmDBModel.swift
//  DataSwiftAssignment
//
//  Created by Angelos Staboulis on 13/7/20.
//  Copyright © 2020 Angelos Staboulis. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class RealmDBModel{
    
    private var realm:Realm
    
    static let sharedInstance  = RealmDBModel()
    
    private init(){
        let config = Realm.Configuration(schemaVersion:2)
        realm = try! Realm(configuration: config)
    }
    
    func addItem(item:RealmModel) {
        try! realm.write{
            realm.add(item, update: .all)
        }
    }
    
    func getItems()->Results<RealmModel>{
        let results:Results<RealmModel> = realm.objects(RealmModel.self)
        return results
    }
    
}
