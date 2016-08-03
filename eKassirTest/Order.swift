//
//  Order.swift
//  eKassirTest
//
//  Created by Владимир Молчанов on 31/07/16.
//  Copyright © 2016 Владимир Молчанов. All rights reserved.
//

import UIKit

class Order: NSObject {
    
    var id: Int!
    var startAddress: Address!
    var endAddress: Address!
    var price: Price!
    var orderTime: String!
    var vehicle: Vehicle!
    
    override init() {
        super.init()
        id = 0
        startAddress = Address()
        endAddress = Address()
        price = Price()
        orderTime = ""
        vehicle = Vehicle()
    }
    
    convenience init(orderParametersDict: [String:AnyObject]) {
        self.init()
        id = orderParametersDict["id"] as? Int ?? 0
        if let startAddressDict = orderParametersDict["startAddress"] as? [String:AnyObject] {
            startAddress = Address(city: startAddressDict["city"] as? String,
                                   address: startAddressDict["address"] as? String)
        }
        if let endAddressDict = orderParametersDict["endAddress"] as? [String:AnyObject] {
            endAddress = Address(city: endAddressDict["city"] as? String,
                                   address: endAddressDict["address"] as? String)
        }
        if let priceDict = orderParametersDict["price"] as? [String:AnyObject] {
            price = Price(amount: priceDict["amount"] as? Int,
                          currency: priceDict["currency"] as? String)
        }
        orderTime = orderParametersDict["orderTime"] as? String ?? ""
        if let vehicleDict = orderParametersDict["vehicle"] as? [String:AnyObject] {
            vehicle = Vehicle(regNumber: vehicleDict["regNumber"] as? String,
                              modelName: vehicleDict["modelName"] as? String,
                              imageName: vehicleDict["photo"] as? String,
                              driverName: vehicleDict["driverName"] as? String)
        }
    }

}
