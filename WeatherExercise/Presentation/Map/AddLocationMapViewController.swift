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
    
    var selectedLocation: LocationModel?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    func setupView() {
        self.presenter = AddLocationMapPresenter()
        self.presenter?.bindView(view: self)
    }
    
    
    override func viewDidLoad() {
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
            
            self.createAnnotation(coordinates: newCoordinates)
        }
    }
    
    func saveLocationPressed() {
        if self.selectedLocation != nil {
            //save current pin location
            self.presenter?.saveLocation(location: self.selectedLocation!)
        }
    }
    
    //MARK: Private Helpers
    fileprivate func createAnnotation(coordinates: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude), completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                self.selectLocation(annotation: annotation)
                return
            }
            
            if placemarks != nil && placemarks!.count > 0 {
                let pm = placemarks!.first!
                
                // not all places have thoroughfare & subThoroughfare so validate those values
                annotation.title = pm.locality
                annotation.subtitle = pm.subLocality
                print(pm)
            }
            else {
                annotation.title = "Unknown Place"
                self.mapView.addAnnotation(annotation)
                print("Problem with the data received from geocoder")
            }
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.mapView.addAnnotation(annotation)
            self.mapView.selectAnnotation(annotation, animated: false)
            
            self.selectLocation(annotation: annotation)
        })
    }
    
    fileprivate func selectLocation(annotation: MKPointAnnotation){
        self.selectedLocation = LocationModel(lat: annotation.coordinate.latitude, lon: annotation.coordinate.longitude, location: String(format:"%@ - %@", annotation.title ?? "", annotation.subtitle ?? ""))
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
