//
//  HomeTableViewController.swift
//  WeatherExercise
//
//  Created by Pedro Brito on 11/05/2017.
//  Copyright © 2017 BringGlobal. All rights reserved.
//

import UIKit

protocol AddLocationDelegate: class {
    func addedLocation()
}

protocol HomeTableViewControllerProtocol: BaseViewControllerProtocol {
    func renderLocations(locations: Array<LocationModel>)
}

class HomeTableViewController: UITableViewController, HomeTableViewControllerProtocol, AddLocationDelegate {
    
    
    var storedLocations: Array<LocationModel>?
    var presenter: HomePresenter?
   
    var reloadDataOnResume = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        self.setupView()
        
        self.presenter?.loadStoredLocations()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if(reloadDataOnResume){
            self.presenter?.loadStoredLocations()
            reloadDataOnResume = false
        }
    }

    //MARK: - BaseViewControllerProtocol Implementation
    func setupView() {
        self.presenter = HomePresenter()
        self.presenter?.bindView(view: self)
        
        var rightButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(HomeTableViewController.editButtonPressed))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    
    //MARK: - Helper Methods
    func editButtonPressed() {
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing == true{
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(HomeTableViewController.editButtonPressed))
        }else{
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(HomeTableViewController.editButtonPressed))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addLocationMapSegue" {
            //add delegate
            (segue.destination as! AddLocationMapViewController).addLocationDelegate = self
        }
        
        if segue.identifier == "showLocationWeather" {
        //TODO: set view controller data
        }
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }
}

//MARK: HomeTableViewControllerProtocol Implementation
extension HomeTableViewController {
    func renderLocations(locations: Array<LocationModel>) {
        self.storedLocations = locations
        self.tableView.reloadData()
    }
}

//MARK: TableView datasource and delegate implementation
extension HomeTableViewController {
    
}

//MARK: AddLocationDelegate implementation
extension HomeTableViewController {
    func addedLocation() {
        self.reloadDataOnResume = true
    }
}
