//
//  NetworkService.swift
//  Weather
//
//  Created by BanGips on 9/22/20.
//

import UIKit

class NetworkService {
    
   static func getData(url: URL, completion: @escaping (Data) -> Void) {
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            completion(data)
        }
        task.resume()
    }

}
