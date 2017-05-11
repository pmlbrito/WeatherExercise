//
//  BaseModels.swift
//  WeatherExercise
//
//  Created by Pedro Brito on 11/05/2017.
//  Copyright © 2017 BringGlobal. All rights reserved.
//

import Foundation
import UIKit

public protocol BasePresenterProtocol: class {
    func bindView(view: UIViewController)
}

public protocol BaseViewControllerProtocol: class {
    func setupView()
}
