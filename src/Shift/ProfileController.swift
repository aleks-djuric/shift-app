//
//  ProfileTabController.swift
//  Shift
//
//  Created by Aleksandar Djuric on 9/20/16.
//  Copyright © 2016 Alphire Studios. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    lazy var profileImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "SampleImage")
        imageView.layer.cornerRadius = self.view.frame.width/3/2
        imageView.contentMode = .scaleAspectFill
        imageView.layer.borderWidth = 1.5
        imageView.layer.borderColor = STANDARD_ORANGE.cgColor
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let verticalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = STANDARD_ORANGE
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let horizontalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = STANDARD_ORANGE
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 100, y: 400, width: 100, height: 50)
        button.setTitle("Sign Out", for: UIControlState())
        button.backgroundColor = UIColor.orange
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.white, for: UIControlState())
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        logoutButton.addTarget(self, action: #selector(self.signOutButtonPressed), for: .touchUpInside)
        
        view.addSubview(logoutButton)
        view.addSubview(horizontalLineView)
        view.addSubview(verticalLineView)
        view.addSubview(profileImage)
        
        setupSubViews()
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
    
    func signOutButtonPressed(_ sender: UIButton!) {
        
        DataService.dataService.signOutUser()
        
    }
    
    func setupSubViews() {
        
        //Setup Profile Image
        profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.width/9).isActive = true
        profileImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.width/9).isActive = true
        profileImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        profileImage.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/3).isActive = true
        
        //Setup Horizontal Line
        horizontalLineView.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
        horizontalLineView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        horizontalLineView.rightAnchor.constraint(equalTo: profileImage.rightAnchor, constant: view.frame.width/9).isActive = true
        horizontalLineView.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        
        //Setup Vertical Line
        verticalLineView.topAnchor.constraint(equalTo: profileImage.topAnchor).isActive = true
        verticalLineView.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor).isActive = true
        verticalLineView.leftAnchor.constraint(equalTo: horizontalLineView.rightAnchor).isActive = true
        verticalLineView.widthAnchor.constraint(equalToConstant: 1.5).isActive = true
        
    }
    
}
