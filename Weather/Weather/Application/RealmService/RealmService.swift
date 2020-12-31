//
//  RealmService.swift
//  TryRealm
//
//  Created by BanGips on 11/19/20.
//

import Foundation
import RealmSwift

class RealmService {
    func create(_ object: Object) {
        let realm = try! Realm()
        try? realm.write {
            realm.add(object, update: .all)
        }
    }

    func getObject<T: Object>(type: T.Type) -> [T] {
        let realm = try! Realm()
        return Array(realm.objects(type))
    }

    func deleteAll() {
        let realm = try! Realm()
        try? realm.write {
            realm.deleteAll()
        }
    }
    
    func deleteObject(_ object: Object) {
        let realm = try! Realm()
        try? realm.write {
            realm.delete(object)
        }
    }

}
