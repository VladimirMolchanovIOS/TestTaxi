//
//  Vehicle.swift
//  eKassirTest
//
//  Created by Владимир Молчанов on 31/07/16.
//  Copyright © 2016 Владимир Молчанов. All rights reserved.
//

import UIKit

class Vehicle: NSObject {
    
    var regNumber: String!
    var modelName: String!
    var imageName: String!
    var driverName: String!
    
    override init() {
        super.init()
        regNumber = ""
        modelName = ""
        imageName = ""
        driverName = ""
    }
    
    convenience init(regNumber: String?, modelName: String?, imageName: String?, driverName: String?) {
        self.init()
        guard let _regNumber = regNumber, _modelName = modelName, _imageName = imageName, _driverName = driverName else { return }
        
        self.regNumber = _regNumber
        self.modelName = _modelName
        self.imageName = _imageName
        self.driverName = _driverName
    }

}
