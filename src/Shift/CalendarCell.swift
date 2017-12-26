//
//  CalendarCell.swift
//  Calendar
//
//  Created by Aleksandar Djuric on 11/15/16.
//  Copyright © 2016 Alphire Studios. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarCell: JTAppleDayCellView {

    let dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: STANDARD_FONT, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var timeOfDayImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let shiftLengthLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: STANDARD_FONT, size: 9)
        label.textAlignment = .center
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let shiftTimeBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.backgroundColor = STANDARD_BLUE
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let startTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: STANDARD_FONT_BOLD, size: 11)
        label.textAlignment = .left
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    let endTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: STANDARD_FONT_BOLD, size: 11)
        label.textAlignment = .right
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    
    var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderColor = STANDARD_ORANGE.cgColor
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let bottomLineView: UIView = {
        let view = UIView()
        view.backgroundColor = LIGHT_GRAY
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        self.addSubview(backgroundView)
        self.addSubview(dayLabel)
        self.addSubview(bottomLineView)
        self.addSubview(timeOfDayImageView)
        self.addSubview(shiftLengthLabel)
        self.addSubview(shiftTimeBackground)
        shiftTimeBackground.addSubview(startTimeLabel)
        shiftTimeBackground.addSubview(endTimeLabel)
        
        setupSubviews()
        
    }
    
    
    func getTimeOfDayImage(startDate: Date) {
        
        let nextDay = Calendar.current.date(byAdding: .day, value: 1, to: startDate)
            
        if startDate >= startDate.dateAt(hours: 4, minutes: 0) && startDate < startDate.dateAt(hours: 11, minutes: 0) {
            timeOfDayImageView.image = UIImage(named: "SunriseIcon")
        }
        else if startDate >= startDate.dateAt(hours: 11, minutes: 0) && startDate < startDate.dateAt(hours: 15, minutes: 0) {
            timeOfDayImageView.image = UIImage(named: "SunIcon")
        }
        else if startDate >= startDate.dateAt(hours: 15, minutes: 0) && startDate < startDate.dateAt(hours: 19, minutes: 0) {
            timeOfDayImageView.image = UIImage(named: "SunsetIcon")
        }
        else if startDate >= startDate.dateAt(hours: 19, minutes: 0) && startDate < (nextDay?.dateAt(hours: 4, minutes: 0))! {
            timeOfDayImageView.image = UIImage(named: "MoonIcon")
        }
        
    }

    
    func setupSubviews() {
        //Setup Background View
        backgroundView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        
        //Setup Day Labels
        dayLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        dayLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        dayLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        dayLabel.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        //Setup Time Of Day Image View
        timeOfDayImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        timeOfDayImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        timeOfDayImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        timeOfDayImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        
        //Setup Shift Length Label
        shiftLengthLabel.topAnchor.constraint(equalTo: timeOfDayImageView.bottomAnchor, constant: 1).isActive = true
        shiftLengthLabel.centerXAnchor.constraint(equalTo: timeOfDayImageView.centerXAnchor, constant: 0).isActive = true
        shiftLengthLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        shiftLengthLabel.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        //Setup Shift Time Background
        shiftTimeBackground.topAnchor.constraint(equalTo: shiftLengthLabel.bottomAnchor, constant: 5).isActive = true
        shiftTimeBackground.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        shiftTimeBackground.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 2).isActive = true
        shiftTimeBackground.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -2).isActive = true
        
        //Setup Start Time Label
        startTimeLabel.leftAnchor.constraint(equalTo: shiftTimeBackground.leftAnchor, constant: 2.5).isActive = true
        startTimeLabel.rightAnchor.constraint(equalTo: shiftTimeBackground.rightAnchor, constant: -2.5).isActive = true
        startTimeLabel.topAnchor.constraint(equalTo: shiftTimeBackground.topAnchor, constant: 2.5).isActive = true
        startTimeLabel.bottomAnchor.constraint(equalTo: shiftTimeBackground.centerYAnchor, constant: -1).isActive = true
        
        //Setup End Time Label
        endTimeLabel.leftAnchor.constraint(equalTo: shiftTimeBackground.leftAnchor, constant: 2.5).isActive = true
        endTimeLabel.rightAnchor.constraint(equalTo: shiftTimeBackground.rightAnchor, constant: -2.5).isActive = true
        endTimeLabel.topAnchor.constraint(equalTo: shiftTimeBackground.centerYAnchor, constant: 1).isActive = true
        endTimeLabel.bottomAnchor.constraint(equalTo: shiftTimeBackground.bottomAnchor, constant: -2.5).isActive = true
        
        //Setup Bottom Line View
        bottomLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bottomLineView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 4).isActive = true
        bottomLineView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -4).isActive = true
        bottomLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
