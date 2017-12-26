//
//  AddShiftController.swift
//  Shift
//
//  Created by Aleksandar Djuric on 1/4/17.
//  Copyright © 2017 Alphire Studios. All rights reserved.
//

import UIKit

class AddShiftController: UIViewController {

    var scheduleController: ScheduleController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        
        let navBarTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        navBarTitleLabel.font = UIFont(name: STANDARD_FONT_BOLD, size: 20)
        navBarTitleLabel.textAlignment = .center
        navBarTitleLabel.text = "Add New Shift"
        self.navigationItem.titleView = navBarTitleLabel
        
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed))
        leftBarButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: STANDARD_FONT_BOLD, size: 15)!], for: UIControlState())
        leftBarButton.tintColor = STANDARD_ORANGE
        self.navigationItem.leftBarButtonItem = leftBarButton
        
    }
    
    func cancelButtonPressed() {
        
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
        
    }

}
