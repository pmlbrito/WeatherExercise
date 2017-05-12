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
    static let locationCellReuseIdentifier = "HomeLocationCellIdentifier"
    
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
        
        let rightButton = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.plain, target: self, action: #selector(HomeTableViewController.editButtonPressed))
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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.storedLocations != nil ? self.storedLocations!.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: HomeTableViewController.locationCellReuseIdentifier) as? HomeLocationTableViewCell
        
        if(cell != nil) {
            if let cellModel = self.storedLocations?[indexPath.row] {
                cell?.setupCell(location: cellModel)
            }
            return cell!
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.delete) {
            if let itemToDelete = self.storedLocations?[indexPath.row] {
                self.presenter?.deleteLocation(location: itemToDelete)
            }
        }
    }
}

//MARK: AddLocationDelegate implementation
extension HomeTableViewController {
    func addedLocation() {
        self.reloadDataOnResume = true
    }
}
