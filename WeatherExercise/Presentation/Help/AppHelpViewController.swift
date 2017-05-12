//
//  AppHelpViewController.swift
//  WeatherExercise
//
//  Created by Pedro Brito on 12/05/2017.
//  Copyright © 2017 BringGlobal. All rights reserved.
//

import UIKit

class AppHelpViewController: UIViewController, UIWebViewDelegate {

    //for now, let's just keep it static... don't really have any real content or behaviour
    static let appHelpURL = "https://openweathermap.org/terms"

    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        self.webView.delegate = self
        if let url = URL(string: AppHelpViewController.appHelpURL) {
            let requestObj = URLRequest(url: url)
            self.webView.loadRequest(requestObj)
        }
    }
}
