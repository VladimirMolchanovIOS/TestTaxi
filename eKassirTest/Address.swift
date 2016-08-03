//
//  Address.swift
//  eKassirTest
//
//  Created by Владимир Молчанов on 31/07/16.
//  Copyright © 2016 Владимир Молчанов. All rights reserved.
//

import UIKit

class Address: NSObject {
    
    var city: String!
    var address: String!
    
    override init() {
        super.init()
        city = ""
        address = ""
    }

    convenience init(city: String?, address: String?) {
        self.init()
        guard let _city = city, _address = address else { return }
        
        self.city = _city
        self.address = _address
    }
}
