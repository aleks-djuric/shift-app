//
//  ShiftDetailsCell.swift
//  Shift
//
//  Created by Aleksandar Djuric on 12/30/16.
//  Copyright © 2016 Alphire Studios. All rights reserved.
//

import UIKit

class ShiftDetailsCell: UITableViewCell {

    let dayInMonthLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: STANDARD_FONT, size: 19)
        label.textColor = STANDARD_ORANGE
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let dayOfWeekLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: STANDARD_FONT, size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let monthAndYearLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: STANDARD_FONT, size: 16)
        label.textColor = UIColor.gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let dayContainer: UIView = {
        var view = UIView()
        view.layer.borderColor = STANDARD_ORANGE.cgColor
        view.layer.borderWidth = 1.0
        view.layer.cornerRadius = 7.0
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let startTimeLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: STANDARD_FONT, size: 18)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let endTimeLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: STANDARD_FONT, size: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = STANDARD_ORANGE
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let locationLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: STANDARD_FONT, size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let shiftTypeLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont(name: STANDARD_FONT, size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupSubviews()
    }

    
    func setupSubviews() {
        
        let nonExpandedView = UIView()
        nonExpandedView.translatesAutoresizingMaskIntoConstraints = false
        
        //Setup Non-Expanded View
        contentView.addSubview(nonExpandedView)
        nonExpandedView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        nonExpandedView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        nonExpandedView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        nonExpandedView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        
        //Setup Day Container
        nonExpandedView.addSubview(dayContainer)
        dayContainer.centerYAnchor.constraint(equalTo: nonExpandedView.centerYAnchor).isActive = true
        dayContainer.leftAnchor.constraint(equalTo: nonExpandedView.leftAnchor, constant: 20).isActive = true
        dayContainer.heightAnchor.constraint(equalToConstant: 40).isActive = true
        dayContainer.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        //Setup Day Label
        dayContainer.addSubview(dayInMonthLabel)
        dayInMonthLabel.centerXAnchor.constraint(equalTo: dayContainer.centerXAnchor).isActive = true
        dayInMonthLabel.centerYAnchor.constraint(equalTo: dayContainer.centerYAnchor).isActive = true
        
        //Setup Day of Week Label
        nonExpandedView.addSubview(dayOfWeekLabel)
        dayOfWeekLabel.topAnchor.constraint(equalTo: dayContainer.topAnchor).isActive = true
        dayOfWeekLabel.leftAnchor.constraint(equalTo: dayContainer.rightAnchor, constant: 15).isActive = true
        dayOfWeekLabel.heightAnchor.constraint(equalTo: dayContainer.heightAnchor, multiplier: 0.45).isActive = true
        dayOfWeekLabel.widthAnchor.constraint(equalTo: nonExpandedView.widthAnchor, multiplier: 0.55).isActive = true
        
        //Setup Month and Year Label
        nonExpandedView.addSubview(monthAndYearLabel)
        monthAndYearLabel.bottomAnchor.constraint(equalTo: dayContainer.bottomAnchor).isActive = true
        monthAndYearLabel.leftAnchor.constraint(equalTo: dayContainer.rightAnchor, constant: 15).isActive = true
        monthAndYearLabel.heightAnchor.constraint(equalTo: dayContainer.heightAnchor, multiplier: 0.45).isActive = true
        monthAndYearLabel.widthAnchor.constraint(equalTo: nonExpandedView.widthAnchor, multiplier: 0.55).isActive = true
        
        //Setup Separator View
        nonExpandedView.addSubview(separatorView)
        separatorView.centerYAnchor.constraint(equalTo: dayContainer.centerYAnchor).isActive = true
        separatorView.leftAnchor.constraint(equalTo: dayOfWeekLabel.rightAnchor).isActive = true
        separatorView.widthAnchor.constraint(equalToConstant: 1.0).isActive = true
        separatorView.heightAnchor.constraint(equalTo: dayContainer.heightAnchor, multiplier: 0.80).isActive = true
        
        //Setup End Time Label
        nonExpandedView.addSubview(endTimeLabel)
        endTimeLabel.topAnchor.constraint(equalTo: separatorView.centerYAnchor).isActive = true
        endTimeLabel.bottomAnchor.constraint(equalTo: separatorView.bottomAnchor).isActive = true
        endTimeLabel.leftAnchor.constraint(equalTo: separatorView.rightAnchor, constant: 5).isActive = true
        endTimeLabel.widthAnchor.constraint(equalToConstant: 85).isActive = true
        
        //Setup Start Time Label
        nonExpandedView.addSubview(startTimeLabel)
        startTimeLabel.topAnchor.constraint(equalTo: separatorView.topAnchor).isActive = true
        startTimeLabel.bottomAnchor.constraint(equalTo: separatorView.centerYAnchor).isActive = true
        startTimeLabel.rightAnchor.constraint(equalTo: separatorView.leftAnchor, constant: -5).isActive = true
        startTimeLabel.widthAnchor.constraint(equalToConstant: 85).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
