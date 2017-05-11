//
//  AddLocationMapViewController.swift
//  WeatherExercise
//
//  Created by Pedro Brito on 11/05/2017.
//  Copyright © 2017 BringGlobal. All rights reserved.
//

import UIKit
import MapKit

protocol AddLocationMapProtocol: BaseViewControllerProtocol {
    func locationSaved()
}

class AddLocationMapViewController: UIViewController, AddLocationMapProtocol  {
    
    var addLocationDelegate: AddLocationDelegate?
    var presenter: AddLocationMapPresenter?

    @IBOutlet weak var mapView: MKMapView!
    
    var selectedLocation: CLPlacemark?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        self.presenter = AddLocationMapPresenter()
        self.presenter?.bindView(view: self)
    }
    
    
    override func viewDidLoad() {
        //TODO: refine map actions
        self.setupMapActions()
        self.setupNavigationBarActions()
    }
    
    fileprivate func setupNavigationBarActions() {
        let rightButton = UIBarButtonItem(title: "Save", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AddLocationMapViewController.saveLocationPressed))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    fileprivate func setupMapActions() {
        let mapTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddLocationMapViewController.addAnnotation(gestureRecognizer:)))
        mapTapRecognizer.numberOfTapsRequired = 1
        self.mapView.addGestureRecognizer(mapTapRecognizer)
    }
    
    func addAnnotation(gestureRecognizer: UIGestureRecognizer){
        if gestureRecognizer.state == UIGestureRecognizerState.ended {
            let touchPoint = gestureRecognizer.location(in: self.mapView)
            let newCoordinates = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
            let annotation = MKPointAnnotation()
            annotation.coordinate = newCoordinates
            
            CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: newCoordinates.latitude, longitude: newCoordinates.longitude), completionHandler: {(placemarks, error) -> Void in
                if error != nil {
                    print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                    return
                }
                
                if placemarks != nil && placemarks!.count > 0 {
                    let pm = placemarks![0] as CLPlacemark
                    
                    // not all places have thoroughfare & subThoroughfare so validate those values
                    annotation.title = pm.locality
                    annotation.subtitle = pm.subLocality
                    self.mapView.removeAnnotations(self.mapView.annotations)
                    self.mapView.addAnnotation(annotation)
                    
                    
                    print(pm)
                }
                else {
                    annotation.title = "Unknown Place"
                    self.mapView.addAnnotation(annotation)
                    print("Problem with the data received from geocoder")
                }
                //places.append(["name":annotation.title,"latitude":"\(newCoordinates.latitude)","longitude":"\(newCoordinates.longitude)"])
            })
            
            self.mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
    func saveLocationPressed() {
        if self.selectedLocation != nil {
            //save current pin location
            self.presenter?.saveLocation(location: self.selectedLocation!)
        }
    }
}

extension AddLocationMapViewController {
    func locationSaved() {
        if(self.addLocationDelegate != nil) {
            self.addLocationDelegate?.addedLocation()
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
