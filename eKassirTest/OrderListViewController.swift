//
//  OrderListViewController.swift
//  eKassirTest
//
//  Created by Владимир Молчанов on 31/07/16.
//  Copyright © 2016 Владимир Молчанов. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

// MARK: - UITableViewDelegate, UITableViewDataSource
extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kTableViewCellHeight
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("OrderCell") as! OrderInfoCell
        
        cell.configureCellForOrder(orders[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        showOrderDetails(orders[indexPath.row])
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

// MARK: - Setup View
extension OrderListViewController {
    private func setupView() {
        setupNavigationItem()
        setupTableView()
        self.tableView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight, .FlexibleTopMargin]
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Заказы"
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: CGRectMake(0.0, navigationController!.navigationBar.frame.maxY, view.bounds.width, view.bounds.height - navigationController!.navigationBar.frame.maxY))
        tableView.registerClass(OrderInfoCell.self, forCellReuseIdentifier: "OrderCell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
}



class OrderListViewController: UIViewController {
// MARK: - Constants
    let kTableViewCellHeight: CGFloat = 95.0
    
// MARK: - Variables
    var orders = [Order]() {
        didSet {
            orders.sortInPlace {$0.id > $1.id}
        }
    }
    
    
// MARK: - UI Variables
    var tableView: UITableView!
    
// MARK: - Controller Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchOrderList()
        setupView()
        automaticallyAdjustsScrollViewInsets = false
    }

    
// MARK: - Helpers
    func fetchOrderList() {
        Alamofire.request(.GET, "http://careers.ekassir.com/test/orders.json")
            .responseJSON { response in
                if response.result.isFailure {
                    print(response.result.error.debugDescription)
                } else {
                    let ordersArray = JSON(response.result.value!).arrayObject as! [[String:AnyObject]]
                    self.orders = ordersArray.map { Order.init(orderParametersDict: $0) }
                    self.tableView.reloadData()
                }
            }
    }
    
// MARK: - Navigation
    func showOrderDetails(order: Order) {
        let orderDetailsController = OrderDetailsViewController(order: order)
        navigationController?.pushViewController(orderDetailsController, animated: true)
    }
    
}
