//
//  CalendarController.swift
//  Shift
//
//  Created by Aleksandar Djuric on 11/20/16.
//  Copyright © 2016 Alphire Studios. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarController: UIViewController, JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    
    var shifts = [Shift]()
    
    let calendarNavBarTitleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        label.font = UIFont(name: STANDARD_FONT, size: 22)
        label.textColor = STANDARD_ORANGE
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let calendarView: JTAppleCalendarView = {
        let view = JTAppleCalendarView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let seperatorContainer = UIView()
    
    let inputContainer: UIView = {
        let view = UIView()
        view.backgroundColor = LIGHT_GRAY
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let dateRibbonLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: STANDARD_FONT, size: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBarController?.tabBar.isHidden = true
        
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = STANDARD_ORANGE
        self.navigationItem.titleView = calendarNavBarTitleLabel
        
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.registerCellViewClass(type: CalendarCell.self)
        calendarView.registerHeaderView(classStringNames: ["Shift.CalendarHeader"])
        
        calendarView.cellInset = CGPoint(x: 0, y: 0)
        
        view.addSubview(calendarView)
        view.addSubview(seperatorContainer)
        setupCalendar()
        
        view.addSubview(inputContainer)
        setupInputContainer()
        
        self.view.bringSubview(toFront: calendarView)
        self.view.bringSubview(toFront: seperatorContainer)
        
        calendarView.scrollToDate(Date(), triggerScrollToDateDelegate: false, animateScroll: false)
        
        calendarView.visibleDates { (visibleDates: DateSegmentInfo) in
            self.setupViewsOfCalendar(from: visibleDates)
        }

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        let customCell = cell as! CalendarCell
        
        // Setup Cell text
        customCell.dayLabel.text = cellState.text
        customCell.shiftTimeBackground.isHidden = true
        customCell.shiftLengthLabel.isHidden = true
        customCell.timeOfDayImageView.isHidden = true
        
        var shiftsInDay =  [Shift]()
        
        let cal = Calendar(identifier: .gregorian)
        
        for shift in shifts {
            if(cal.startOfDay(for: shift.startTime!) == date) {
                shiftsInDay.append(shift)
            }
        }
        
        if(shiftsInDay.count >= 1) {
            let dateFormatter = DateFormatter()
            
            dateFormatter.amSymbol = "a"
            dateFormatter.pmSymbol = "p"
            dateFormatter.dateFormat = "h:mma"
            
            customCell.startTimeLabel.text = dateFormatter.string(from: shiftsInDay[0].startTime!)
            customCell.endTimeLabel.text = dateFormatter.string(from: shiftsInDay[0].endTime!)
            
            let lengthOfShift = Int(shiftsInDay[0].endTime!.timeIntervalSince1970 - shiftsInDay[0].startTime!.timeIntervalSince1970)
            customCell.shiftLengthLabel.text = String(format: "%0.1f h", lengthOfShift/3600)
            
            customCell.getTimeOfDayImage(startDate: shiftsInDay[0].startTime!)
            
            customCell.shiftTimeBackground.isHidden = false
            customCell.shiftLengthLabel.isHidden = false
            customCell.timeOfDayImageView.isHidden = false
            
        } else if(shiftsInDay.count > 1) {
            
        }
        
        handleCellSelection(view: cell, cellState: cellState, date: date)
    }
    
    
    func handleCellSelection(view: JTAppleDayCellView?, cellState: CellState, date: Date) {
        
        guard let customCell = view as? CalendarCell  else {
            return
        }
        
        let comparison = Calendar.current.compare(Date(), to: date, toGranularity: .day)
        
        if cellState.isSelected && customCell.backgroundView.isHidden {
            
            customCell.backgroundView.layer.cornerRadius =  5
            customCell.backgroundView.isHidden = false
            customCell.dayLabel.textColor = .black
            customCell.bottomLineView.isHidden = true
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMMM d, YYYY"  //EEEE for day of the week
            dateRibbonLabel.text = dateFormatter.string(from: date)
            
        } else {
            
            customCell.backgroundView.isHidden = true
            customCell.bottomLineView.isHidden = false
            
            if comparison == ComparisonResult.orderedSame {
                customCell.dayLabel.textColor = STANDARD_ORANGE
            } else if cellState.dateBelongsTo == .thisMonth {
                customCell.dayLabel.textColor = .black
            } else {
                customCell.dayLabel.textColor = .gray
            }
            
        }
        
    }
    
    
    func handleInputContainerAnimation(view: JTAppleDayCellView?, cellState: CellState) {
        
        guard let customCell = view as? CalendarCell  else {
            return
        }
        
        if customCell.backgroundView.isHidden == false && (self.inputContainerTopAnchor?.constant)! < CGFloat(0) {
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut, animations: {
                self.inputContainerTopAnchor?.constant += (self.inputContainerHeightAnchor?.constant)!
                self.inputContainer.alpha = 1
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        
        if customCell.backgroundView.isHidden == true && (self.inputContainerTopAnchor?.constant)! == CGFloat(0){
            dateRibbonLabel.text = ""
            UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
                self.inputContainerTopAnchor?.constant -= (self.inputContainerHeightAnchor?.constant)!
                self.inputContainer.alpha = 0
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, sectionHeaderSizeFor range: (start: Date, end: Date), belongingTo month: Int) -> CGSize {
        return CGSize(width: view.frame.height, height: 20)
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplaySectionHeader header: JTAppleHeaderView, range: (start: Date, end: Date), identifier: String) {
    }
    
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let startDate = Calendar.current.date(byAdding: .year, value: -1, to: Date())   // You can use date generated from a formatter
        let endDate = Calendar.current.date(byAdding: .year, value: 2, to: Date())      // You can also use dates created from this function
        let parameters = ConfigurationParameters(startDate: startDate!,
                                                 endDate: endDate!,
                                                 numberOfRows: 6,
                                                 calendar: Calendar.current,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .tillEndOfGrid,
                                                 firstDayOfWeek: .sunday)
        return parameters
    }
    
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first else {
            return
        }
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MMMM YYYY"
        let monthAndYear = dateFormatter.string(from: startDate)
        calendarNavBarTitleLabel.text = monthAndYear
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
    }
    
    
    func scrollDidEndDecelerating(for calendar: JTAppleCalendarView) {
        self.setupViewsOfCalendar(from: calendarView.visibleDates())
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleCellSelection(view: cell, cellState: cellState, date: date)
        handleInputContainerAnimation(view: cell, cellState: cellState)
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleCellSelection(view: cell, cellState: cellState, date: date)
    }
    
    
    func setupCalendar() {
        
        //Setup of Calendar Container
        calendarView.topAnchor.constraint(equalTo: view.topAnchor, constant: 65).isActive = true
        calendarView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4).isActive = true
        calendarView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -4).isActive = true
        calendarView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
        
        //Setup Seperator Container
        seperatorContainer.backgroundColor = .white
        seperatorContainer.translatesAutoresizingMaskIntoConstraints = false
        
        seperatorContainer.topAnchor.constraint(equalTo: calendarView.bottomAnchor).isActive = true
        seperatorContainer.leftAnchor.constraint(equalTo: calendarView.leftAnchor).isActive = true
        seperatorContainer.rightAnchor.constraint(equalTo: calendarView.rightAnchor).isActive = true
        seperatorContainer.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        //Setup Seperator Line
        let seperatorLine = UIView()
        seperatorLine.backgroundColor = STANDARD_ORANGE
        seperatorLine.translatesAutoresizingMaskIntoConstraints = false
        
        seperatorContainer.addSubview(seperatorLine)
        
        seperatorLine.bottomAnchor.constraint(equalTo: seperatorContainer.bottomAnchor).isActive = true
        seperatorLine.leftAnchor.constraint(equalTo: seperatorContainer.leftAnchor).isActive = true
        seperatorLine.rightAnchor.constraint(equalTo: seperatorContainer.rightAnchor).isActive = true
        seperatorLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
    
    
    var inputContainerTopAnchor: NSLayoutConstraint?
    var inputContainerHeightAnchor: NSLayoutConstraint?
    
    func setupInputContainer() {
        
        //Setup of Input Container View
        inputContainer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 4).isActive = true
        inputContainer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -4).isActive = true
        inputContainerHeightAnchor = inputContainer.heightAnchor.constraint(equalToConstant: 150)
        inputContainerHeightAnchor?.isActive = true
        inputContainerTopAnchor = inputContainer.topAnchor.constraint(equalTo: seperatorContainer.bottomAnchor, constant: -(inputContainerHeightAnchor?.constant)!)
        inputContainerTopAnchor?.isActive = true
        
        //Setup Date Ribbon Background
        let dateRibbonBackground = UIView()
        dateRibbonBackground.backgroundColor = STANDARD_ORANGE
        dateRibbonBackground.translatesAutoresizingMaskIntoConstraints = false
        
        inputContainer.addSubview(dateRibbonBackground)
        
        dateRibbonBackground.topAnchor.constraint(equalTo: inputContainer.topAnchor).isActive = true
        dateRibbonBackground.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 0).isActive = true
        dateRibbonBackground.rightAnchor.constraint(equalTo: inputContainer.rightAnchor).isActive = true
        dateRibbonBackground.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //Setup Date Ribbon Label
        dateRibbonBackground.addSubview(dateRibbonLabel)
        
        dateRibbonLabel.topAnchor.constraint(equalTo: dateRibbonBackground.topAnchor).isActive = true
        dateRibbonLabel.leftAnchor.constraint(equalTo: dateRibbonBackground.leftAnchor, constant: 4).isActive = true
        dateRibbonLabel.bottomAnchor.constraint(equalTo: dateRibbonBackground.bottomAnchor).isActive = true
        dateRibbonLabel.rightAnchor.constraint(equalTo: dateRibbonBackground.rightAnchor).isActive = true
        
        //Setup Start Label
        let startLabel = UILabel()
        startLabel.text = "Start:"
        startLabel.font = UIFont(name: STANDARD_FONT, size: 20)
        startLabel.textColor = STANDARD_ORANGE
        startLabel.translatesAutoresizingMaskIntoConstraints = false
        
        inputContainer.addSubview(startLabel)
        
        startLabel.leftAnchor.constraint(equalTo: inputContainer.leftAnchor, constant: 10).isActive = true
        startLabel.topAnchor.constraint(equalTo: dateRibbonBackground.bottomAnchor, constant: 10).isActive = true
        startLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        startLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //Setup Start Input
        let startInput = UITextField()
        startInput.translatesAutoresizingMaskIntoConstraints = false
        
        inputContainer.addSubview(startInput)
        
        startInput.leftAnchor.constraint(equalTo: startLabel.rightAnchor, constant: 5).isActive = true
        startInput.topAnchor.constraint(equalTo: dateRibbonBackground.bottomAnchor, constant: 10).isActive = true
        startInput.widthAnchor.constraint(equalToConstant: 50).isActive = true
        startInput.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        //Setup End Label
        let endLabel = UILabel()
        endLabel.text = "End:"
        endLabel.font = UIFont(name: STANDARD_FONT, size: 20)
        endLabel.textColor = STANDARD_ORANGE
        endLabel.translatesAutoresizingMaskIntoConstraints = false
        
        inputContainer.addSubview(endLabel)
        
        endLabel.leftAnchor.constraint(equalTo: startInput.rightAnchor, constant: 10).isActive = true
        endLabel.topAnchor.constraint(equalTo: dateRibbonBackground.bottomAnchor, constant: 10).isActive = true
        endLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        endLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //Setup End Input
        let endInput = UITextField()
        endInput.translatesAutoresizingMaskIntoConstraints = false
        
        inputContainer.addSubview(endInput)
        
        endInput.leftAnchor.constraint(equalTo: endLabel.rightAnchor, constant: 5).isActive = true
        endInput.topAnchor.constraint(equalTo: dateRibbonBackground.bottomAnchor, constant: 10).isActive = true
        endInput.widthAnchor.constraint(equalToConstant: 50).isActive = true
        endInput.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }
    
}
