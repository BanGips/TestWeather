//
//  CoreDataService.swift
//  Weather
//
//  Created by BanGips on 31.12.20.
//

import Foundation
import CoreData
import UIKit

class CoreDataService: NSObject {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    private lazy var managedObjectContext = {
        return appDelegate.persistentContainer.viewContext
    }()
    
    func create(dataForSaving: AllWeatherParameters) {
        
        do {
            let test = try managedObjectContext.fetch(fetchRequestPredicate(idPredicate: Int32(dataForSaving.city.id)))
            
            if test.isEmpty {
                createEntityFrom(dataSource: dataForSaving)
                saveData()
            } else {
                let updateWeather = test.first
                updateWeather?.temp = dataForSaving.mainParameters.first?.main.temp ?? 0
                updateWeather?.icon = dataForSaving.mainParameters.first?.weatherList.first?.icon ?? ""
                saveData()
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func createEntityFrom(dataSource: AllWeatherParameters) {
        
        let weatherItem = AllWeather(context: managedObjectContext)
        weatherItem.id = Int32(dataSource.id)
        weatherItem.name = dataSource.city.name
        weatherItem.temp = dataSource.mainParameters.first?.main.temp ?? 0
        weatherItem.icon = dataSource.mainParameters.first?.weatherList.first?.icon ?? ""
    }
    
    private func fetchRequestPredicate(idPredicate: Int32) -> NSFetchRequest<AllWeather> {
        let fetchRequest: NSFetchRequest<AllWeather> = AllWeather.fetchRequest()
        let idPredicate = NSPredicate(format: "id = %@", String(idPredicate))
        fetchRequest.predicate = idPredicate
        
        return fetchRequest
    }
    
    func saveData(){
        
        let context = self.managedObjectContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func read() -> [AllWeather] {
        let fetchRequest: NSFetchRequest<AllWeather> = AllWeather.fetchRequest()
        var items = [AllWeather]()
        
        do {
            items = try managedObjectContext.fetch(fetchRequest)
        } catch {
            print(error.localizedDescription)
        }
        
        return items
    }
    
    func deleteObject(name: String) {
        let fetchRequest: NSFetchRequest<AllWeather> = AllWeather.fetchRequest()
        do {
            let result = try managedObjectContext.fetch(fetchRequest)
            if result.count > 0 {
                for item in result {
                    if item.name == name {
                        managedObjectContext.delete(item)
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        do {
            try managedObjectContext.save()
        } catch let error {
            print(error)
        }
    }
    
    func deleteAll()  {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "AllWeather")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try managedObjectContext.execute(deleteRequest)
        } catch  {
            print(error.localizedDescription)
        }
    }
}
