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
        
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode == 200 {
                        completion(data, nil)
                    } else {
                        let userInfo = [NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")]
                        let error = NSError(domain: NetworkingErrorDomain, code: httpResponse.statusCode, userInfo: userInfo)
                        completion(nil, error)
                    }
                } else {
                    completion(nil, error)
                }
            
            }
            
        }
        task.resume()
    }

}
