//
//  Price.swift
//  eKassirTest
//
//  Created by Владимир Молчанов on 31/07/16.
//  Copyright © 2016 Владимир Молчанов. All rights reserved.
//

import UIKit

class Price: NSObject {
    
    var amount: Int!
    var currency: String!
    
    override init() {
        super.init()
        amount = 0
        currency = ""
    }
    
    convenience init(amount: Int?, currency: String?) {
        self.init()
        guard let _amount = amount, _currency = currency else { return }
        
        self.amount = _amount
        self.currency = _currency
    }

}
