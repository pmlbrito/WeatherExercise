//
//  TodayWeatherModel.swift
//  WeatherExercise
//
//  Created by Pedro Brito on 11/05/2017.
//  Copyright © 2017 BringGlobal. All rights reserved.
//

import Foundation

class TodayWeatherModel {

    var location: LocationModel?
    
    var mainStatus: String?
    var mainDescription: String?
    
    var temp_min: Double?
    var temp: Double?
    var temp_max: Double?
    
    var wind_speed: Double?
    var wind_direction: Double?
    
    var humidity: Int?
    var rain: Int?
    
    init(model: Dictionary<String,Any?>){
        //build model from dictionary
        
        if let coordinates = model["coord"] as? Dictionary<String,Any?> {
            self.location = LocationModel(lat: coordinates["lat"] as? Double, lon: coordinates["lon"] as? Double)
        }
        
        if let weatherArray = model["weather"] as? Array<Dictionary<String, Any?>> {
            if let weather = weatherArray.first {
                mainStatus = weather["main"] as? String
                mainDescription = weather["description"] as? String
            }
        }
        
        if let main = model["main"] as? Dictionary<String,Any?> {
            temp_min = main["temp_min"] as? Double
            temp = main["temp"] as? Double
            temp_max = main["temp_max"] as? Double
            
            humidity = main["humidity"] as? Int
        }
        
        if let windDict = model["wind"] as? Dictionary<String,Any?> {
            wind_speed = windDict["speed"] as? Double
            wind_direction = windDict["deg"] as? Double
        }
        
        if let cloudsDict = model["clouds"] as? Dictionary<String,Any?> {
            rain = cloudsDict["all"] as? Int
        }
    }
}
