//
//  OrderParameterGeneralCell.swift
//  eKassirTest
//
//  Created by Владимир Молчанов on 02/08/16.
//  Copyright © 2016 Владимир Молчанов. All rights reserved.
//

import UIKit

class OrderParameterGeneralCell: UITableViewCell {
// MARK: - Constants
    private let kHorizontalPadding: CGFloat = 10.0
    private let kTopPadding: CGFloat = 10.0
    private let kBottomPadding: CGFloat = 10.0
// MARK: ParameterDescriptionLabel
    private let kParameterDescriptionLabelFont = UIFont.systemFontOfSize(11.0)
    private let kParameterDescriptionLabelTextColor = UIColor(red: 138.0/255.0, green: 143.0/255.0, blue: 146.0/255.0, alpha: 1.0)
    private let kParameterDescriptionLabelBottomSpace: CGFloat = 5.0
// MARK: ParameterValueLabel
    private let kPriceLabelLeftSpace: CGFloat = 10.0
    private let kParameterValueLabelFont = UIFont.systemFontOfSize(14.0)
// MARK: - UI Variables
    var parameterDescriptionLabel: UILabel!
    var parameterValueLabel: UILabel!
    
// MARK: - Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let labelsWidth = bounds.width - 2*kHorizontalPadding
        
        parameterDescriptionLabel.sizeToFitWithWidth(labelsWidth)
        var parameterDescriptionLabelFrame = parameterDescriptionLabel.frame
        parameterDescriptionLabelFrame.origin = CGPointMake(
            kHorizontalPadding,
            kTopPadding)
        parameterDescriptionLabel.frame = parameterDescriptionLabelFrame
        
        
        parameterValueLabel.sizeToFitWithWidth(labelsWidth)
        var parameterValueLabelFrame = parameterValueLabel.frame
        parameterValueLabelFrame.origin = CGPointMake(
            kHorizontalPadding,
            parameterDescriptionLabelFrame.maxY + kParameterDescriptionLabelBottomSpace)
        parameterValueLabel.frame = parameterValueLabelFrame
        
    }
    
// MARK: - View
    private func setupView() {
        setupMargins()
        setupParameterDescriptionLabel()
        setupParameterValueLabel()
    }
    
    private func setupMargins() {
        layoutMargins = UIEdgeInsetsZero
        preservesSuperviewLayoutMargins = false
    }
    
    private func setupParameterDescriptionLabel() {
        parameterDescriptionLabel = UILabel()
        parameterDescriptionLabel.textAlignment = .Left
        parameterDescriptionLabel.font = kParameterDescriptionLabelFont
        parameterDescriptionLabel.textColor = kParameterDescriptionLabelTextColor
        parameterDescriptionLabel.numberOfLines = 1
        addSubview(parameterDescriptionLabel)
    }
    
    private func setupParameterValueLabel() {
        parameterValueLabel = UILabel()
        parameterValueLabel.textAlignment = .Right
        parameterValueLabel.lineBreakMode = .ByTruncatingMiddle
        parameterValueLabel.font = kParameterValueLabelFont
        parameterValueLabel.numberOfLines = 1
        parameterValueLabel.adjustsFontSizeToFitWidth = true
        addSubview(parameterValueLabel)
    }
    
// MARK: - Helpers
    func setFormattedPrice(amount: Int, currency: String) {
        let formatter = NSNumberFormatter()
        let decimalNumber = NSDecimalNumber(integer: amount/100)
        formatter.numberStyle = .CurrencyISOCodeStyle
        formatter.currencyCode = currency
        var formattedPrice = formatter.stringFromNumber(decimalNumber)
        formattedPrice!.insert(" ", atIndex: formattedPrice!.startIndex.advancedBy(currency.characters.count))
        
        parameterValueLabel.text = formattedPrice
    }
}
