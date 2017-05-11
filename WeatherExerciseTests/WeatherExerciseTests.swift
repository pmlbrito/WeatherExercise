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
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        APIDataManager.getTodaysWeather(location: nil) { (model, error) in
            
            XCTAssert(model != nil)
            
            XCTAssert(error == nil)
        }
    }
    
}
