//
//  ModalCollectionViewCell.swift
//  FoodApplication
//
//  Created by Tigran VIasyan on 06.12.22.
//

import UIKit

class ModalTableViewCell: UITableViewCell {
    
    //MARK: Properties
    static let identifier: String = "ModalTableViewCell"
    
    lazy var filterLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    lazy var selectedImage: UIImageView = {
        let image = UIImageView()
        image.isHidden = true
        image.image = UIImage(named: "checkbox-16-32")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    func setupUI(type: FilterTypes) {
        setupConstraints()
        filterLabel.text = type.rawValue
        selectedImage.isHidden = true
    }
    
    func setupConstraints() {
        contentView.addSubview(filterLabel)
        filterLabel.sizeToFit()
        filterLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0).isActive = true
        filterLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        filterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        filterLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        contentView.addSubview(selectedImage)
        selectedImage.topAnchor.constraint(equalTo: filterLabel.topAnchor, constant: 0).isActive = true
        selectedImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        selectedImage.widthAnchor.constraint(equalToConstant: 32).isActive = true
        selectedImage.bottomAnchor.constraint(equalTo: filterLabel.bottomAnchor, constant: 0).isActive = true
        //
    }
}
