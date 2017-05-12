//
//  CityLocationDetailPresenter.swift
//  WeatherExercise
//
//  Created by Pedro Brito on 12/05/2017.
//  Copyright © 2017 BringGlobal. All rights reserved.
//

import UIKit

protocol CityLocationDetailPresenterProtocol: BasePresenterProtocol {
    func loadWeather(location: LocationModel)
}

class CityLocationDetailPresenter: CityLocationDetailPresenterProtocol {

    var view:  CityLocationDetailViewController?
    
    func loadWeather(location: LocationModel) {
        if self.view == nil {
            return
        }
        
        (self.view! as UIViewController).showLoadingOverlay()
        
        APIDataManager.getTodaysWeather(location: location, completionHandler: { (weather, error) in
            
            DispatchQueue.main.async {
                (self.view! as UIViewController).hideLoadingOverlay()
                
                if error != nil {
                    (self.view! as UIViewController).showError(error: error!)
                    return
                }
                
                if weather != nil {
                    self.view?.renderLocationWeather(weather: weather!)
                }
            }
        })
    }
}

//MARK: - BasePresenterProtocol Implementation
extension CityLocationDetailPresenter {
    func bindView(view: UIViewController) {
        self.view = view as? CityLocationDetailViewController
    }
}
