//
//  NetworkService.swift
//  Weather
//
//  Created by BanGips on 9/22/20.
//

import UIKit

class NetworkService {
    
   static func getData(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, responce, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
            
        }
        task.resume()
    }

}
