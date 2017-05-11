//
//  HomePresenter.swift
//  WeatherExercise
//
//  Created by Pedro Brito on 11/05/2017.
//  Copyright © 2017 BringGlobal. All rights reserved.
//

import UIKit
import Foundation

public protocol HomePresenterProtocol: BasePresenterProtocol {
    func loadStoredLocations()
}

class HomePresenter: HomePresenterProtocol {

    var view: HomeTableViewController?
    
    //MARK: - BasePresenterProtocol Implementation
    func bindView(view: UIViewController) {
        self.view = view as? HomeTableViewController
    }
}


//MARK: - HomePresenterProtocol Implementation
extension HomePresenter {
    func loadStoredLocations() {
        
    }
}

