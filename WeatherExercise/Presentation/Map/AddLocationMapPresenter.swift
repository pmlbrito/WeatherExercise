//
//  AddLocationMapPresenter.swift
//  WeatherExercise
//
//  Created by Pedro Brito on 11/05/2017.
//  Copyright © 2017 BringGlobal. All rights reserved.
//

import Foundation
import MapKit
import UIKit

protocol AddLocationPresenterProtocol: BasePresenterProtocol {
    func saveLocation(location: LocationModel)
}

class AddLocationMapPresenter: AddLocationPresenterProtocol {
    
    var view: AddLocationMapViewController?
    
    func saveLocation(location: LocationModel) {
        //save and go back
        if self.view == nil {
            return
        }
        
        (self.view! as UIViewController).showLoadingOverlay()
        
        DispatchQueue.global(qos: .userInitiated).async {
            SharedPreferencesStorageManager.shared.addLocation(location: location)
            
            DispatchQueue.main.async {
                (self.view! as UIViewController).hideLoadingOverlay()
                self.view?.locationSaved()
            }
        }
    }
}

extension AddLocationMapPresenter {
    func bindView(view: UIViewController) {
        self.view = view as? AddLocationMapViewController
    }
}
