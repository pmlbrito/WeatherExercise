//
//  WeatherExerciseTests.swift
//  WeatherExerciseTests
//
//  Created by Pedro Brito on 11/05/2017.
//  Copyright © 2017 BringGlobal. All rights reserved.
//

import XCTest
@testable import WeatherExercise

class WeatherExerciseTests: XCTestCase {
    
    //MARK: - Helpers
    fileprivate func prepareForStorageTests(){
        SharedPreferencesStorageManager.shared.clearStoredLocations()
    }
    
    //MARK: - TESTS
    func testAPICall() {
        
        APIDataManager.getTodaysWeather(location: nil) { (model, error) in
            XCTAssert(model != nil)
            
            XCTAssert(error == nil)
        }
    }
    
    //test api conversion
    func testAPIConversionWithBadObj() {
         let invalidJSONDictionaryObject = "[{\"test\":\"object\"}]" //it's an array
    
        XCTAssert(APIDataManager.convertToDictionary(data: invalidJSONDictionaryObject.data(using: .utf8)!) == nil)
    }

    func testAPIResponseToDictionaryConversion() {
        let validJSONDictionaryObject = "{\"test\":\"object\", \"with\":\"properties\"}" //it's a dictionary
        
        XCTAssert(APIDataManager.convertToDictionary(data: validJSONDictionaryObject.data(using: .utf8)!) != nil)
    }
    
    //test location storage
    func testSaveLocation() {
        self.prepareForStorageTests()
        
        XCTAssert(SharedPreferencesStorageManager.shared.getStoredLocations().count == 0)
        
        let local1 = LocationModel(lat: 0.1, lon: 0.1, location: "test1")
        SharedPreferencesStorageManager.shared.addLocation(location: local1)
        XCTAssert(SharedPreferencesStorageManager.shared.getStoredLocations().count == 1)
    }
    
    func testDeleteLocation() {
        self.prepareForStorageTests()
        
        XCTAssert(SharedPreferencesStorageManager.shared.getStoredLocations().count == 0)
        
        let local1 = LocationModel(lat: 0.1, lon: 0.1, location: "test1")
        SharedPreferencesStorageManager.shared.addLocation(location: local1)
        
        XCTAssert(SharedPreferencesStorageManager.shared.getStoredLocations().count == 1)
        
        SharedPreferencesStorageManager.shared.deleteLocation(location: local1)
        
        XCTAssert(SharedPreferencesStorageManager.shared.getStoredLocations().count == 0)
        
    }
    
    func testLocationStorageDeleteAllLocationRecords() {
        self.prepareForStorageTests()
        
        let local1 = LocationModel(lat: 0.1, lon: 0.1, location: "test1")
        let local2 = LocationModel(lat: 0.11, lon: 0.11, location: "test2")
        let local3 = LocationModel(lat: 0.111, lon: 0.111, location: "test3")
    
        SharedPreferencesStorageManager.shared.addLocation(location: local1)
        SharedPreferencesStorageManager.shared.addLocation(location: local2)
        SharedPreferencesStorageManager.shared.addLocation(location: local3)
        
        XCTAssert(SharedPreferencesStorageManager.shared.getStoredLocations().count == 3)
        
        SharedPreferencesStorageManager.shared.clearStoredLocations()
        
        XCTAssert(SharedPreferencesStorageManager.shared.getStoredLocations().count == 0)
    }
    
    func testLoadLocationFromStorage() {
        self.prepareForStorageTests()
        
        XCTAssert(SharedPreferencesStorageManager.shared.getStoredLocations().count == 0)
        
        let local1 = LocationModel(lat: 0.1, lon: 0.1, location: "test1")
        SharedPreferencesStorageManager.shared.addLocation(location: local1)
        
        let loadedlocations = SharedPreferencesStorageManager.shared.getStoredLocations()
        
        XCTAssert(loadedlocations.count == 1)
        
        let loaded = loadedlocations.first
        
        XCTAssert(loaded?.latitude == local1.latitude && loaded?.longitude == local1.longitude && loaded?.locationName == local1.locationName)
        
    }
    
    //TODO: test model parsing
    
}
