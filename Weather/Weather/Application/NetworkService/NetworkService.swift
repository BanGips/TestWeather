//
//  NetworkService.swift
//  Weather
//
//  Created by BanGips on 9/22/20.
//

import UIKit

class NetworkService {
    
   static func getData(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, response, error)
            }
            
        }
        task.resume()
    }

}
