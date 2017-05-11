//
//  BaseViewController.swift
//  WeatherExercise
//
//  Created by Pedro Brito on 11/05/2017.
//  Copyright © 2017 BringGlobal. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showLoadingOverlay() {
        LoadingOverlay.shared.showOverlay(view: self.view)
    }
    
    func hideLoadingOverlay() {
        LoadingOverlay.shared.hideOverlayView()
    }
    
    func showError(error: Error) {
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        
        alertController.addAction(defaultAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
