//
//  SharedPreferencesStorageManager.swift
//  WeatherExercise
//
//  Created by Pedro Brito on 11/05/2017.
//  Copyright © 2017 BringGlobal. All rights reserved.
//

import Foundation

class SharedPreferencesStorageManager {
    
    fileprivate static let locationsStorageKey = "locations"

    fileprivate var userDefaults: UserDefaults!
    
    static let shared = SharedPreferencesStorageManager()
    private init(){
        self.userDefaults = UserDefaults.standard
    }
    
    
    func addLocation(location: LocationModel){
        var locations = self.getLocationsArrayFromStorage()
        
        //already exists
        if locations.contains(where: { (model) -> Bool in
            return model.latitude == location.latitude && model.longitude == location.longitude
            }) {
            return
        }
        
        locations.append(location)
        
        self.saveLocationsToStorage(locations: locations)
    }
    
    func deleteLocation(location: LocationModel){
        var locations = self.getLocationsArrayFromStorage()
        
        let itemToDelete = locations.first { (model) -> Bool in
            return model.latitude == location.latitude && model.longitude == location.longitude
        }
        
        //nothing to do
        if(itemToDelete == nil){
            return
        }
        
        if(itemToDelete != nil){
            let deletionIdx = locations.index(of: itemToDelete!)
            
            if(deletionIdx != NSNotFound){
                locations.remove(at: deletionIdx!)
            }
        }
        
        self.saveLocationsToStorage(locations: locations)
    }
    
    func getStoredLocations() -> Array<LocationModel> {
        return self.getLocationsArrayFromStorage()
    }
    
    func clearStoredLocations() {
        userDefaults.set(nil, forKey: SharedPreferencesStorageManager.locationsStorageKey)
        userDefaults.synchronize()
    }
    
    fileprivate func getLocationsArrayFromStorage() -> Array<LocationModel> {
        let decoded  = userDefaults.object(forKey: SharedPreferencesStorageManager.locationsStorageKey) as! Data
        let decodedArray = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? Array<LocationModel>
        
        return decodedArray ?? Array<LocationModel>()
    }
    
    fileprivate func saveLocationsToStorage(locations: Array<LocationModel>) {
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: locations)
        userDefaults.set(encodedData, forKey: SharedPreferencesStorageManager.locationsStorageKey)
        userDefaults.synchronize()
    }
}
