//
//  APIDataManager.swift
//  WeatherExercise
//
//  Created by Pedro Brito on 11/05/2017.
//  Copyright © 2017 BringGlobal. All rights reserved.
//

import Foundation

class APIDataManager {
    
    fileprivate static let apiKey = "c6e381d8c7ff98f0fee43775817cf6ad"
    fileprivate static let baseURL = "http://api.openweathermap.org/data/2.5/"

    
    public static func getTodaysWeather(location: LocationModel?, completionHandler:@escaping (TodayWeatherModel?, Error?)->Void){
        let requestPath = String(format: "%@%@?", baseURL, "weather")
        
        var queryString = ""
        if(location == nil){
            let defaultLocation = LocationModel()
            queryString = defaultLocation.getQueryCoordinates()
        }else{
            queryString = location!.getQueryCoordinates()
        }
        
        queryString.append(String(format: "&appid=%@&units=metric", apiKey))
    
        let urlWithParams = requestPath + queryString
        
        if let weatherUrl = URL(string: urlWithParams) {
            var request = URLRequest(url: weatherUrl, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: TimeInterval(15.0))
            request.httpMethod = "GET"

            APIDataManager.executeRequest(request: request, completionHandler: { (data, response, error) in
                
                if(error != nil) {
                    completionHandler(nil, error)
                }
                
                if(data != nil) {
                    if let parsedResponse = APIDataManager.convertToDictionary(data: data!) {
                        let parsedModel = TodayWeatherModel(model:parsedResponse)
                        parsedModel.location = location
                        
                        completionHandler(parsedModel, nil)
                        return
                    }
                }
                
                let genericError = NSError(domain: "API", code: 2, userInfo: [NSLocalizedDescriptionKey: "Unable to satisfy request"])
                completionHandler(nil, genericError)
            })
        }
    }
    
    
    //MARK: Helper methods
    static func executeRequest(request: URLRequest, completionHandler:@escaping (Data?, URLResponse?, Error?)->Void){
        // Excute HTTP Request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                print(error!)
                completionHandler(nil, nil, error)
                return
            }
            guard let data = data else {
                print("Data is empty")
                completionHandler(nil, response, nil)
                return
            }
            
            completionHandler(data, response, error)
        }
        
        task.resume()
    }
    
    
    static func convertToDictionary(data: Data) -> Dictionary<String,Any?>? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? Dictionary<String,Any?>
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
