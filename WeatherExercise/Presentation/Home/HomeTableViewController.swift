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
    
    func addNewLocation()
}

class HomeTableViewController: UITableViewController, HomeTableViewControllerProtocol {
    
    
    var storedLocations: Array<LocationModel>?
    var presenter: HomePresenter?
   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        self.setupView()
        
        self.presenter?.loadStoredLocations()
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
        if(segue.identifier == ""){
            //navigate to map pin add screen
        }
    }
}

//MARK: HomeTableViewControllerProtocol Implementation
extension HomeTableViewController {
    func renderLocations(locations: Array<LocationModel>) {
        self.storedLocations = locations
        self.tableView.reloadData()
    }
    
    func addNewLocation() {
        self.performSegue(withIdentifier: "", sender: self)
    }
}

//MARK: TableView datasource and delegate implementation
extension HomeTableViewController {
    
}
