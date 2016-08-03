//
//  OrderParameterCarInfoCell.swift
//  eKassirTest
//
//  Created by Владимир Молчанов on 02/08/16.
//  Copyright © 2016 Владимир Молчанов. All rights reserved.
//

import UIKit
import Alamofire

class OrderParameterCarInfoCell: UITableViewCell {
//MARK: - Constants
    private let kHorizontalPadding: CGFloat = 10.0
    private let kTopPadding: CGFloat = 10.0
    private let kVerticalSpace: CGFloat = 5.0
//MARK: ParameterDescriptionLabel
    private let kParameterDescriptionLabelFont = UIFont.systemFontOfSize(11.0)
    private let kParameterDescriptionLabelTextColor = UIColor(red: 138.0/255.0, green: 143.0/255.0, blue: 146.0/255.0, alpha: 1.0)
//MARK: ParameterValueLabels
    private let kParameterValueLabelFont = UIFont.systemFontOfSize(14.0)
//MARK: - UI Variables
    var parameterDescriptionLabel: UILabel!
    var carModelNameLabel: UILabel!
    var carRegNumberLabel: UILabel!
    var carPhotoImageView: UIImageView!
    
//MARK: - Variables
    var imageURL: String!
    var imageViewHeight: CGFloat = 0.0
    
//MARK: - Initialization
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    convenience init(imageURL: String) {
        self.init(style: .Default, reuseIdentifier: nil)
        self.imageURL = imageURL
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        parameterDescriptionLabel.sizeToFit()
        var parameterDescriptionLabelFrame = parameterDescriptionLabel.frame
        parameterDescriptionLabelFrame.origin = CGPointMake(
            kHorizontalPadding,
            kTopPadding)
        parameterDescriptionLabel.frame = parameterDescriptionLabelFrame
        
        carRegNumberLabel.sizeToFit()
        var carRegNumberLabelFrame = carRegNumberLabel.frame
        carRegNumberLabelFrame.origin = CGPointMake(
            bounds.width - kHorizontalPadding - carRegNumberLabelFrame.width,
            parameterDescriptionLabelFrame.maxY + kVerticalSpace)
        carRegNumberLabel.frame = carRegNumberLabelFrame
        
        carModelNameLabel.sizeToFit()
        var carModelNameLabelFrame = carModelNameLabel.frame
        carModelNameLabelFrame.origin = CGPointMake(
            kHorizontalPadding,
            parameterDescriptionLabelFrame.maxY + kVerticalSpace)
        carModelNameLabel.frame = carModelNameLabelFrame
        
        if let carImage = carPhotoImageView.image {
            self.imageViewHeight = (self.bounds.width - 2*self.kHorizontalPadding) * (carImage.size.height/carImage.size.width)
        } 
        carPhotoImageView.frame = CGRectMake(
            kHorizontalPadding,
            carModelNameLabelFrame.maxY + kVerticalSpace,
            bounds.width - 2*kHorizontalPadding,
            imageViewHeight)
        
    }
    
//MARK: - View
    private func setupView() {
        setupMargins()
        setupParameterDescriptionLabel()
        setupCarRegNumberLabel()
        setupCarModelNameLabel()
        setupCarPhotoImageView()
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
    
    private func setupCarRegNumberLabel() {
        carRegNumberLabel = UILabel()
        carRegNumberLabel.textAlignment = .Right
        carRegNumberLabel.font = kParameterValueLabelFont
        carRegNumberLabel.numberOfLines = 1
        addSubview(carRegNumberLabel)
    }
    
    private func setupCarModelNameLabel() {
        carModelNameLabel = UILabel()
        carModelNameLabel.textAlignment = .Left
        carModelNameLabel.font = kParameterValueLabelFont
        carModelNameLabel.numberOfLines = 1
        addSubview(carModelNameLabel)
    }
    
    private func setupCarPhotoImageView() {
        carPhotoImageView = UIImageView()
        getCarImage()
        carPhotoImageView.userInteractionEnabled = false
        carPhotoImageView.contentMode = .ScaleAspectFit
        addSubview(carPhotoImageView)
    }
    
    func getCarImage() {
        imageRequest(imageURL)
    }
    
    func imageRequest(imageURL: String) -> Void {
        Alamofire.request(.GET, imageURL).validate(contentType: ["image/*"]).responseData { [unowned self]
            response in
            if !response.result.isFailure && response.data != nil {
                let downloadedImage = UIImage(data: response.data!)!
                self.carPhotoImageView.image = downloadedImage
                self.layoutSubviews()
            } else {
                print("Image has not been loaded: \(imageURL). Description: \(response.debugDescription)")
            }
        }
    }
}

