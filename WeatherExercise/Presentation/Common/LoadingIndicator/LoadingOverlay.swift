//
//  LoadingOverlay.swift
//  WeatherExercise
//
//  Created by Pedro Brito on 11/05/2017.
//  Copyright © 2017 BringGlobal. All rights reserved.
//

import Foundation
import UIKit

class LoadingOverlay: UIView {
    
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    class var shared: LoadingOverlay {
        struct Static {
            static let instance: LoadingOverlay = LoadingOverlay(frame: CGRect.zero)
        }
        return Static.instance
    }
    
    func showOverlay(view: UIView) {
        self.frame = view.bounds
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        
        overlayView.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
        overlayView.center = view.center
        overlayView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.5)
        overlayView.clipsToBounds = true
        overlayView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.center = overlayView.center
        
        overlayView.addSubview(activityIndicator)
        self.addSubview(overlayView)
        view.addSubview(self)
        
        activityIndicator.startAnimating()
    }
    
    public func hideOverlayView() {
        activityIndicator.stopAnimating()
        self.removeFromSuperview()
    }
}

