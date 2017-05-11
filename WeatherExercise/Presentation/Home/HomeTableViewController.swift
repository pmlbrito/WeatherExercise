//
//  HomeTableViewController.swift
//  WeatherExercise
//
//  Created by Pedro Brito on 11/05/2017.
//  Copyright © 2017 BringGlobal. All rights reserved.
//

import UIKit

protocol HomeTableViewControllerProtocol: BaseViewControllerProtocol {
    func renderLocations(locations: Array<LocationModel>)
}

class HomeTableViewController: UITableViewController, HomeTableViewControllerProtocol {
    
    
    var storedLocations: Array<LocationModel>?
    var presenter: HomePresenter?
   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        self.setupView()
    }

    //MARK: - BaseViewControllerProtocol Implementation
    func setupView() {
        self.presenter = HomePresenter()
        self.presenter?.bindView(view: self)
    }
}

extension HomeTableViewController {
    func renderLocations(locations: Array<LocationModel>) {
        self.storedLocations = locations
        
        self.tableView.reloadData()
    }
}
