//
//  FirstController.swift
//  Shift
//
//  Created by Aleksandar Djuric on 9/21/16.
//  Copyright © 2016 Alphire Studios. All rights reserved.
//

import UIKit

class FirstController: UIViewController {

    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let buttonBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: UIControlState())
        button.backgroundColor = UIColor.white
        button.setTitleColor(STANDARD_ORANGE, for: UIControlState())
        button.layer.borderWidth = 2.0
        button.layer.borderColor = STANDARD_ORANGE.cgColor
        button.titleLabel?.font = UIFont(name: STANDARD_FONT, size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: UIControlState())
        button.backgroundColor = STANDARD_ORANGE
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.titleLabel?.font = UIFont(name: STANDARD_FONT, size: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
                
        view.addSubview(logoImageView)
        view.addSubview(buttonBackgroundView)
        view.addSubview(signInButton)
        view.addSubview(registerButton)
        
        setupLogoImageView()
        setupButtonBackgroundView()
        setupSignInButton()
        setupRegisterButton()
        
    }
    
    func signInButtonPressed () {
        let signInController = SignInController()
        
        present(signInController, animated: true, completion: nil)
        
    }
    
    func registerButtonPressed () {
        let registrationController = Registration1()
        
        let registrationNavController = UINavigationController(rootViewController: registrationController)
        
        present(registrationNavController, animated: true, completion: nil)
        
    }
    
    func setupLogoImageView() {
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true

    }
    
    func setupButtonBackgroundView() {
        buttonBackgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        buttonBackgroundView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        buttonBackgroundView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        buttonBackgroundView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.12 ).isActive = true
    }
    
    func setupSignInButton() {
        signInButton.topAnchor.constraint(equalTo: buttonBackgroundView.topAnchor, constant: 10).isActive = true
        signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        signInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        signInButton.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -7.5).isActive = true
    }
    
    func setupRegisterButton() {
        registerButton.topAnchor.constraint(equalTo: buttonBackgroundView.topAnchor, constant: 10).isActive = true
        registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10).isActive = true
        registerButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 7.5).isActive = true
        registerButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true

    }
    
}


