//
//  OrderInfoCell.swift
//  eKassirTest
//
//  Created by Владимир Молчанов on 31/07/16.
//  Copyright © 2016 Владимир Молчанов. All rights reserved.
//


import UIKit
import Foundation

class OrderInfoCell: UITableViewCell {
// MARK: - Constants
    static let reuseIdentifier = "OrderCell"
    private let kTopPadding: CGFloat = 10.0
    private let kBottomPadding: CGFloat = 10.0
    private let kLeftPadding: CGFloat = 10.0
    private let kRightPadding: CGFloat = 35.0
// MARK: DateLabel
    private let kDateLabelFont = UIFont.systemFontOfSize(11.0)
    private let kDateLabelTextColor = UIColor(red: 138.0/255.0, green: 143.0/255.0, blue: 146.0/255.0, alpha: 1.0)
    private let kDateLabelBottomSpace: CGFloat = 5.0
// MARK: WaypointLabels
    private let kWaypointLabelFont = UIFont.systemFontOfSize(14.0)
    private let kWaypointLabelWidthFromCellWidth: CGFloat = 0.6
// MARK: ArrowLabel
    private let kArrowLabelVerticalSpace: CGFloat = 0.0
    private let kArrowLabelFont = UIFont.systemFontOfSize(15.0)
// MARK: PriceLabel
    private let kPriceLabelLeftSpace: CGFloat = 10.0
    private let kPriceLabelTextColor = UIColor(red: 234.0/255.0, green: 28.0/255.0, blue: 41.0/255.0, alpha: 1.0)
    private let kPriceLabelFont = UIFont.systemFontOfSize(12.0)
// MARK: - UI Variables
    private var dateLabel: UILabel!
    private var originLabel: UILabel!
    private var arrowLabel: UILabel!
    private var destinationLabel: UILabel!
    private var priceLabel: UILabel!
    
// MARK: - Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    internal func configureCellForOrder(order: Order) {
        originLabel.text = order.startAddress.address
        destinationLabel.text = order.endAddress.address
        dateLabel.text = order.orderTime.componentsSeparatedByString("T").first!
        setFormattedPrice(order.price.amount, currency: order.price.currency)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        dateLabel.sizeToFit()
        var dateLabelFrame = dateLabel.frame
        dateLabelFrame.origin = CGPointMake(
            kLeftPadding,
            kTopPadding)
        dateLabel.frame = dateLabelFrame
        
        
        let labelsWidth = bounds.width * kWaypointLabelWidthFromCellWidth
        
        originLabel.sizeToFitWithWidth(labelsWidth)
        var originLabelFrame = originLabel.frame
        originLabelFrame.origin = CGPointMake(
            kLeftPadding,
            dateLabelFrame.maxY + kDateLabelBottomSpace)
        originLabel.frame = originLabelFrame
        
        arrowLabel.sizeToFit()
        var arrowLabelFrame = arrowLabel.frame
        arrowLabelFrame.origin = CGPointMake(
            kLeftPadding,
            originLabelFrame.maxY + kArrowLabelVerticalSpace)
        arrowLabel.frame = arrowLabelFrame
        
        
        destinationLabel.sizeToFitWithWidth(labelsWidth)
        var destinationLabelFrame = destinationLabel.frame
        destinationLabelFrame.origin = CGPointMake(
            kLeftPadding,
            arrowLabelFrame.maxY + kArrowLabelVerticalSpace)
        destinationLabel.frame = destinationLabelFrame
        

        let priceLabelWidth = bounds.width - kLeftPadding - originLabelFrame.width - kRightPadding
        priceLabel.sizeToFitWithWidth(priceLabelWidth)
        var priceLabelFrame = priceLabel.frame
        priceLabelFrame.origin = CGPointMake(
            bounds.width - kRightPadding - priceLabelFrame.width,
            bounds.height/2 - priceLabelFrame.height/2)
        priceLabel.frame = priceLabelFrame

    }
    
    //MARK: - View
    private func setupView() {
        setupMargins()
        self.accessoryType = .DisclosureIndicator
        setupDateLabel()
        setupOriginLabel()
        setupArrowLabel()
        setupDestinationLabel()
        setupPriceLabel()
    }
    
    private func setupMargins() {
        layoutMargins = UIEdgeInsetsZero
        preservesSuperviewLayoutMargins = false
    }
    
    private func setupDateLabel() {
        dateLabel = UILabel()
        dateLabel.textAlignment = .Left
        dateLabel.font = kDateLabelFont
        dateLabel.textColor = kDateLabelTextColor
        dateLabel.numberOfLines = 1
        addSubview(dateLabel)
    }
    
    private func setupOriginLabel() {
        originLabel = UILabel()
        originLabel.textAlignment = .Left
        originLabel.lineBreakMode = .ByTruncatingMiddle
        originLabel.font = kWaypointLabelFont
        originLabel.numberOfLines = 1
        originLabel.adjustsFontSizeToFitWidth = true
        addSubview(originLabel)
    }
    
    private func setupArrowLabel() {
        arrowLabel = UILabel()
        arrowLabel.text = "⇣"
        arrowLabel.textAlignment = .Center
        arrowLabel.font = kArrowLabelFont
        arrowLabel.numberOfLines = 1
        addSubview(arrowLabel)
    }
    
    private func setupDestinationLabel() {
        destinationLabel = UILabel()
        destinationLabel.textAlignment = .Left
        destinationLabel.lineBreakMode = .ByTruncatingMiddle
        destinationLabel.font = kWaypointLabelFont
        destinationLabel.numberOfLines = 1
        originLabel.adjustsFontSizeToFitWidth = true
        addSubview(destinationLabel)
    }
    
    private func setupPriceLabel() {
        priceLabel = UILabel()
        priceLabel.textAlignment = .Right
        priceLabel.lineBreakMode = .ByTruncatingTail
        priceLabel.font = kPriceLabelFont
        priceLabel.textColor = kPriceLabelTextColor
        priceLabel.numberOfLines = 1
        addSubview(priceLabel)
    }
    
    
// MARK: - Helpers
    func setFormattedPrice(amount: Int, currency: String) {
        let formatter = NSNumberFormatter()
        let decimalNumber = NSDecimalNumber(integer: amount/100)
        formatter.numberStyle = .CurrencyISOCodeStyle
        formatter.currencyCode = currency
        var formattedPrice = formatter.stringFromNumber(decimalNumber)
        formattedPrice!.insert(" ", atIndex: formattedPrice!.startIndex.advancedBy(currency.characters.count))
        
        priceLabel.text = formattedPrice
    }
}

extension UIView {
    func sizeToFitWithWidth(width: CGFloat) {
        sizeToFit()
        frame.size = CGSizeMake(width, frame.size.height)
    }
}
