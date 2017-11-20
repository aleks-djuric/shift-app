//
//  CalendarHeader.swift
//  Calendar
//
//  Created by Aleksandar Djuric on 11/15/16.
//  Copyright © 2016 Alphire Studios. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarHeader: JTAppleHeaderView {
    
    let daysOfWeek = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        var labels = [UILabel]()
        
        for day in daysOfWeek {
            labels.append(createLabelFor(day: day))
        }
        
        let stackView = UIStackView(arrangedSubviews: labels)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 0
        stackView.contentMode = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = STANDARD_ORANGE
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(backgroundView)
        backgroundView.addSubview(stackView)
        
        //Setup Background View
        backgroundView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        //Setup StackView
        stackView.topAnchor.constraint(equalTo: backgroundView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor).isActive = true
        stackView.leftAnchor.constraint(equalTo: backgroundView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: backgroundView.rightAnchor).isActive = true
        
    }
    
    func createLabelFor(day: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: STANDARD_FONT, size: 17)
        label.textColor = .white
        label.textAlignment = .center
        label.text = day
        return label
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

