//
//  ScheduleController.swift
//  Shift
//
//  Created by Aleksandar Djuric on 11/20/16.
//  Copyright © 2016 Alphire Studios. All rights reserved.
//

import UIKit

enum ShiftType: String {
    case Basic = "Basic"
    case ShiftSupervisor = "Shift Supervisor"
    case Manager = "Manager"
    
}

class Shift {
    
    var location: String?
    var shiftType: ShiftType?
    var startTime: Date?
    var endTime: Date?
    var isExpanded = false
    
    init(location: String?, shiftType: ShiftType?, startTime: Date?, endTime: Date?) {
        self.location = location
        self.shiftType = shiftType
        self.startTime = startTime
        self.endTime = endTime
    }
    
}

class ScheduleController: UITableViewController {

    let cellID = "ShiftDetailsCell"
    
    var shifts = [Shift]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        navBarTitleLabel.font = UIFont(name: STANDARD_FONT_BOLD, size: 20)
        navBarTitleLabel.textAlignment = .center
        navBarTitleLabel.text = "Schedule"
        self.navigationItem.titleView = navBarTitleLabel
        
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed))
        leftBarButton.tintColor = STANDARD_ORANGE
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "CalendarIcon"), style: .plain, target: self, action: #selector(calendarButtonPressed))
        rightBarButton.tintColor = STANDARD_ORANGE
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        //Changes backBarItem in the Calendar Controller
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        tableView.register(ShiftDetailsCell.self, forCellReuseIdentifier: cellID)
        
        tableView.estimatedRowHeight = 65
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let shift = Shift(location: "1286 Cumnock Crescent", shiftType: .Basic, startTime: Date(), endTime: Date())

        shifts.append(shift)
        shifts.append(shift)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    func addButtonPressed() {
        let addShiftController = AddShiftController()
        addShiftController.scheduleController = self
        let addShiftNavController = UINavigationController(rootViewController: addShiftController)
        present(addShiftNavController, animated: true, completion: nil)
    }
    
    
    func calendarButtonPressed() {
        let calendarController = CalendarController()
        calendarController.shifts = shifts
        navigationController?.pushViewController(calendarController, animated: true)
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shifts.count != 0 {
            tableView.separatorStyle = .none
            tableView.backgroundView = nil
        }
        return shifts.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ShiftDetailsCell
        
        cell.selectionStyle = .none

        let dateFormatter = DateFormatter()
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        
        dateFormatter.dateFormat = "dd"
        cell.dayInMonthLabel.text = dateFormatter.string(from: shifts[indexPath.row].startTime!)
        
        dateFormatter.dateFormat = "EEEE"
        cell.dayOfWeekLabel.text = dateFormatter.string(from: shifts[indexPath.row].startTime!)
        
        dateFormatter.dateFormat = "MMMM, yyyy"
        cell.monthAndYearLabel.text = dateFormatter.string(from: shifts[indexPath.row].startTime!)
        
        dateFormatter.dateFormat = "h:mm a"
        cell.startTimeLabel.text = dateFormatter.string(from: shifts[indexPath.row].startTime!)
        cell.endTimeLabel.text = dateFormatter.string(from: shifts[indexPath.row].endTime!)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        var indexPathToReturn: IndexPath?
        let shift = shifts[indexPath.row]
        
        if shift.isExpanded {
            shift.isExpanded = false
            
            tableView.deselectRow(at: indexPath, animated: true)
            self.tableView(tableView, didDeselectRowAt: indexPath)
            
        } else {
            shift.isExpanded = true
            indexPathToReturn = indexPath
        }
        
        //shifts[indexPath.row] = shift
        
        return indexPathToReturn
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

}
