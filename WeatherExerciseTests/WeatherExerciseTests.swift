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
    
    
    //TODO: test model parsing
    
}
