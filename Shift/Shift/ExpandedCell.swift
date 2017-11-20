//
//  ExpandedCellView.swift
//  Shift
//
//  Created by Aleksandar Djuric on 1/15/17.
//  Copyright © 2017 Alphire Studios. All rights reserved.
//

import UIKit


class ExpandedCellView: UITableViewCell {
    
    let shiftTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "What is this for"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.cyan
        
        setupSubviews()
    }
    
    
    func setupSubviews() {
        
        //Add Shift Type Label
        self.addSubview(shiftTypeLabel)
        shiftTypeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        shiftTypeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        shiftTypeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
