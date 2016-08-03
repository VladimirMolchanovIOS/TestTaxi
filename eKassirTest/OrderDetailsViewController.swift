//
//  OrderDetailsViewController.swift
//  eKassirTest
//
//  Created by Владимир Молчанов on 02/08/16.
//  Copyright © 2016 Владимир Молчанов. All rights reserved.
//

import UIKit
import Alamofire

enum OrderParameterCellType {
    case General(OrderParameter)
    case CarInfo
}

enum OrderParameter {
    case StartAddress
    case EndAddress
    case Date
    case Time
    case Price
    case DriverName
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension OrderDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        switch cellTypeForIndexPath(indexPath) {
        case .General(_):
            return kOrderParameterGeneralCellHeight
        case .CarInfo:
            return kOrderParameterCarInfoCellHeight
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch cellTypeForIndexPath(indexPath) {
        case .CarInfo:
            let cell = OrderParameterCarInfoCell(imageURL: "http://careers.ekassir.com/test/images/" + order.vehicle.imageName)
            cell.parameterDescriptionLabel.text = "АВТОМОБИЛЬ"
            cell.carRegNumberLabel.text = order.vehicle.regNumber
            cell.carModelNameLabel.text = order.vehicle.modelName
            return cell
        case .General(_):
            let cell = OrderParameterGeneralCell(style: .Default, reuseIdentifier: nil)
            switch cellTypeForIndexPath(indexPath) {
            case .General(.Date):
                cell.parameterDescriptionLabel.text = "ДАТА"
                cell.parameterValueLabel.text = order.orderTime.componentsSeparatedByString("T").first!
            case .General(.Time):
                cell.parameterDescriptionLabel.text = "ВРЕМЯ"
                cell.parameterValueLabel.text = order.orderTime.componentsSeparatedByString("T").last!.componentsSeparatedByString("+").first!
            case .General(.StartAddress):
                cell.parameterDescriptionLabel.text = "ПУНКТ ОТПРАВЛЕНИЯ"
                cell.parameterValueLabel.text = order.startAddress.address
            case .General(.EndAddress):
                cell.parameterDescriptionLabel.text = "ПУНКТ НАЗНАЧЕНИЯ"
                cell.parameterValueLabel.text = order.endAddress.address
            case .General(.Price):
                cell.parameterDescriptionLabel.text = "ЦЕНА"
                cell.setFormattedPrice(order.price.amount, currency: order.price.currency)
            case .General(.DriverName):
                cell.parameterDescriptionLabel.text = "ВОДИТЕЛЬ"
                cell.parameterValueLabel.text = order.vehicle.driverName
            default:
                return cell
            }
            return cell
        }
    }
}

// MARK: - TableViewDataSource Helper
    private func cellTypeForIndexPath(indexPath: NSIndexPath) -> OrderParameterCellType {
        switch indexPath.row {
        case 0:
            return .General(.Date)
        case 1:
            return .General(.Time)
        case 2:
            return .General(.StartAddress)
        case 3:
            return .General(.EndAddress)
        case 4:
            return .General(.Price)
        case 5:
            return .General(.DriverName)
        default:
            return .CarInfo
    }
}

// MARK: = Setup View
extension OrderDetailsViewController {
    private func setupView() {
        setupNavigationItem()
        setupTableView()
        self.tableView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight, .FlexibleTopMargin]
    }
    
    private func setupNavigationItem() {
        navigationItem.title = "Заказ №\(order.id)"
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: CGRectMake(0.0, navigationController!.navigationBar.frame.maxY, view.bounds.width, view.bounds.height - navigationController!.navigationBar.frame.maxY))
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
}


class OrderDetailsViewController: UIViewController {
// MARK: - Constants
    private let kOrderParameterGeneralCellHeight: CGFloat = 50.0
    private let kOrderParameterCarInfoCellHeight: CGFloat = 350.0
    
// MARK: - Variables
    var order: Order!
    
// MARK: - UI Variables
    var tableView: UITableView!
    
// MARK: - Initialization
    convenience init(order: Order) {
        self.init()
        self.order = order
    }
    
// MARK: - Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        tableView.allowsSelection = false
        automaticallyAdjustsScrollViewInsets = false
    }
    
}
