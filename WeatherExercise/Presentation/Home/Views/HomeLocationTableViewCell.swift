//
//  HomeLocationTableViewCell.swift
//  WeatherExercise
//
//  Created by Pedro Brito on 12/05/2017.
//  Copyright © 2017 BringGlobal. All rights reserved.
//

import UIKit

class HomeLocationTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupCell(location: LocationModel) {
        self.textLabel?.text = location.locationName
        
        self.detailTextLabel?.text = location.getCoordinatesText()
    }
}
