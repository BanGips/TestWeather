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

    func getObject<T: Object>(type: T.Type) -> Results<T> {
        let realm = try! Realm()
        return realm.objects(type)
    }

    func delete() {
        let realm = try! Realm()
        try? realm.write {
            realm.deleteAll()
        }
    }

}
