//
//  ChooseContactCell.swift
//  Shift
//
//  Created by Aleksandar Djuric on 10/21/16.
//  Copyright © 2016 Alphire Studios. All rights reserved.
//

import UIKit

class ChooseContactCell: UITableViewCell {

    let profileImage: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = 22.5
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let contactNameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: STANDARD_FONT, size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(profileImage)
        contentView.addSubview(contactNameLabel)
        
        setupSubviews()
        
    }
    
   
    func setupSubviews() {
        
        //Setup Profile Image
        profileImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        profileImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 45).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 45).isActive = true
        
        //Setup Contact Name Label
        contactNameLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 20).isActive = true
        contactNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -100).isActive = true
        contactNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        contactNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
