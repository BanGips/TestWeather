//
//  RealmService.swift
//  TryRealm
//
//  Created by BanGips on 11/19/20.
//

import Foundation
import RealmSwift

class RealmService: DataBaseProtocol {
    
    func read() -> [DataFormDataBase] {
            let realm = try! Realm()
            let resultFormDataBase = Array(realm.objects(AllWeatherParameters.self))
            let result = resultFormDataBase.map { createItems($0) }
            
            return result
    }
    
    private func createItems(_ object :AllWeatherParameters) -> DataFormDataBase {
        let url = URL(string: "https://openweathermap.org/img/wn/\(object.mainParameters.first!.weatherList.first!.icon)@2x.png")
        return DataFormDataBase(id: object.id,
                                name: object.city.name,
                                temp: object.mainParameters.first!.main.temp,
                                icon: url!)
    }
    
  
    func create(_ object: AllWeatherParameters) {
        let realm = try! Realm()
        try? realm.write {
            realm.add(object, update: .all)
        }
    }
    
    func deleteObject(id: Int) {
        let realm = try! Realm()
        let idPredicate = NSPredicate(format: "id = %d", id)
        let result = getObject().filter(idPredicate)
        
        try? realm.write {
            realm.delete(result)
        }
    }
    
    func getObject() -> Results<AllWeatherParameters> {
        let realm = try! Realm()
        return realm.objects(AllWeatherParameters.self)
    }
    
    func deleteAll() {
        let realm = try! Realm()
        try? realm.write {
            realm.deleteAll()
        }
    }
}
