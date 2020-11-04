//
//  NetworkRouter.swift
//  Weather
//
//  Created by BanGips on 11/4/20.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?) -> Void

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        let url = URL(string: route.path, relativeTo: route.baseURL)!
        var request = URLRequest(url: url)
//        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
//                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
//                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
        switch route.task {
        case .request:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
    
}
