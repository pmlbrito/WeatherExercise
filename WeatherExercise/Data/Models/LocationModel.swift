//
//  LocationModel.swift
//  WeatherExercise
//
//  Created by Pedro Brito on 11/05/2017.
//  Copyright © 2017 BringGlobal. All rights reserved.
//

import Foundation

class LocationModel: NSObject, NSCoding {
    
    var locationName: String?
    var latitude: Double
    var longitude: Double

    override init() {
        self.latitude = 0.0
        self.longitude = 0.0
        self.locationName = ""
    }
    
    init(lat: Double?, lon: Double?){
        self.latitude = lat ?? 0.0
        self.longitude = lon ?? 0.0
    }
    
    convenience init(lat: Double?, lon: Double?, location: String?){
        self.init(lat: lat, lon: lon)
        self.locationName = location ?? ""
    }
    
    
    //MARK: NSCoding and Serialization
    required convenience init(coder aDecoder: NSCoder) {
        let latitude = aDecoder.decodeDouble(forKey: "latitude")
        let longitude = aDecoder.decodeDouble(forKey: "longitude")
        let location = aDecoder.decodeObject(forKey: "locationName") as? String
        self.init(lat: latitude, lon: longitude, location: location)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(latitude, forKey: "latitude")
        aCoder.encode(longitude, forKey: "longitude")
        aCoder.encode(locationName, forKey: "locationName")
    }
    
    
    func getId() -> String {
        //just for simplicity sake
        return self.getQueryCoordinates()
    }
    
    func getQueryCoordinates() -> String {
        return String(format:"lat=%d&lon=%d", self.latitude, self.longitude)
    }
    
}
