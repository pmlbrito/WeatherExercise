//
//  LocationModel.swift
//  WeatherExercise
//
//  Created by Pedro Brito on 11/05/2017.
//  Copyright © 2017 BringGlobal. All rights reserved.
//

import Foundation

class LocationModel {
    var latitude: Double
    var longitude: Double

    init() {
        self.latitude = 0.0
        self.longitude = 0.0
    }
    
    init(lat: Double?, lon: Double?){
        self.latitude = lat ?? 0.0
        self.longitude = lon ?? 0.0
    }
    
    
    
    func getQueryCoordinates() -> String {
        return String(format:"lat=%d&lon=%d", self.latitude, self.longitude)
    }
    
}
