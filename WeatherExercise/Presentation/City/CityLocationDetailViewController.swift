//
//  CityLocationDetailViewController.swift
//  WeatherExercise
//
//  Created by Pedro Brito on 12/05/2017.
//  Copyright © 2017 BringGlobal. All rights reserved.
//

import UIKit

protocol CityLocationDetailProtocol: BaseViewControllerProtocol {
    func setupLocation(location: LocationModel)
    
    func renderLocationWeather(weather: TodayWeatherModel)
}

class CityLocationDetailViewController: UIViewController, CityLocationDetailProtocol {
    
    var selectedLocation: LocationModel?
    var presenter: CityLocationDetailPresenter?
    
    
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var tempCurrLabel: UILabel!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.loadWeather()
    }
    
    func setupView() {
        self.presenter = CityLocationDetailPresenter()
        self.presenter?.bindView(view: self)
    }
    
    //MARK: Private Helpers
    fileprivate func loadWeather(){
        if self.selectedLocation != nil {
            self.presenter?.loadWeather(location: self.selectedLocation!)
        }
    }
}

extension CityLocationDetailViewController {
    func setupLocation(location: LocationModel) {
        self.selectedLocation = location
    }
    
    func renderLocationWeather(weather: TodayWeatherModel) {
        self.locationNameLabel.text = weather.location?.locationName
        
        self.statusLabel.text = String(format:"%@ - %@", weather.mainStatus != nil ? weather.mainStatus! : "", weather.mainDescription != nil ? weather.mainDescription! : "")
        
        self.tempMinLabel.text = weather.temp_min != nil ? "\(weather.temp_min!)" : "n/a"
        self.tempCurrLabel.text = weather.temp != nil ? "\(weather.temp!)" : "n/a"
        self.tempMaxLabel.text = weather.temp_max != nil ? "\(weather.temp_max!)" : "n/a"
        
        self.windSpeedLabel.text = weather.wind_speed != nil ? "\(weather.wind_speed!)" : "n/a"
        self.windDirectionLabel.text = weather.wind_direction != nil ? "\(weather.wind_direction!)" : "n/a"
        
        self.humidityLabel.text = weather.humidity != nil ? "\(weather.humidity!)" : "n/a"
        self.rainLabel.text = weather.rain != nil ? "\(weather.rain!)" : "n/a"
    }
}
