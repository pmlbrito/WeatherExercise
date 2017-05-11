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
    func saveLocation(location: CLPlacemark)
}

class AddLocationMapPresenter: AddLocationPresenterProtocol {
    
    var view: AddLocationMapViewController?
    
    func saveLocation(location: CLPlacemark) {
        //TODO: save and go back
    }
}

extension AddLocationMapPresenter {
    func bindView(view: UIViewController) {
        self.view = view as? AddLocationMapViewController
    }
}
