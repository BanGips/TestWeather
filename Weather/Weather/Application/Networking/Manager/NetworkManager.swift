//
//  NetworkManager.swift
//  Weather
//
//  Created by BanGips on 11/4/20.
//

import Foundation
import CoreLocation

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

struct NetworkManager {
    static let WeatherAPIKey = "43eb687365c30bfd88ebe5bf42cf46d1"
    let router = Router<WeatherApi>()
    private let realm = RealmService()
    private let coreData = CoreDataService()
    
    func getWeather(cityName: String?, location: CLLocationCoordinate2D?, completion: @escaping (_ weather: AllWeatherParameters?,_ error: String?) -> Void) {
        var requestType: WeatherApi!
        
        if let cityName = cityName {
            requestType = .byCity(cityName: cityName)
        } else if let location = location {
            requestType = .byCoordinates(lalitude: location.latitude, longitude: location.longitude)
        }
        
        router.request(requestType) { (data, response, error) in
         
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return }
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .secondsSince1970
                    
                    do {
                        let apiResponse = try decoder.decode(AllWeatherParameters.self, from: responseData)
                        completion(apiResponse,nil)
                        
                        DispatchQueue.main.async {
                            apiResponse.id = apiResponse.city.id
                            realm.create(apiResponse)
                            coreData.create(apiResponse)
                        }  
                    } catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
            
        }
    }
    
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
