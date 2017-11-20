//
//  MessagePreviewCell.swift
//  Shift
//
//  Created by Aleksandar Djuric on 10/12/16.
//  Copyright © 2016 Alphire Studios. All rights reserved.
//

import UIKit

class MessagePreviewCell: UITableViewCell {
    
    var profileImage: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = 22.5
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var contactNameLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: STANDARD_FONT, size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var lastMessageLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: STANDARD_FONT, size: 15)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var timeOfLastMessage: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: STANDARD_FONT, size: 14)
        label.textColor = UIColor.gray
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    let verticalSeperator: UIView = {
        let view = UIView()
        view.backgroundColor = STANDARD_ORANGE
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(verticalSeperator)
        contentView.addSubview(profileImage)
        contentView.addSubview(contactNameLabel)
        contentView.addSubview(lastMessageLabel)
        contentView.addSubview(timeOfLastMessage)
        
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
        contactNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -120).isActive = true
        contactNameLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0).isActive = true
        contactNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //Setup Last Message Label
        lastMessageLabel.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 20).isActive = true
        lastMessageLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        lastMessageLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 1).isActive = true
        lastMessageLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        //Setup Time of Last Message
        timeOfLastMessage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        timeOfLastMessage.leftAnchor.constraint(equalTo: contactNameLabel.rightAnchor, constant: 10).isActive = true
        timeOfLastMessage.bottomAnchor.constraint(equalTo: contactNameLabel.bottomAnchor).isActive = true
        timeOfLastMessage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //Setup Vertical Seperator
        verticalSeperator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        verticalSeperator.heightAnchor.constraint(equalToConstant: 25).isActive = true
        verticalSeperator.leftAnchor.constraint(equalTo: profileImage.leftAnchor, constant: -10).isActive = true
        verticalSeperator.widthAnchor.constraint(equalToConstant: 2).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
