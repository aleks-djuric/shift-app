//
//  SignInController.swift
//  Shift
//
//  Created by Aleksandar Djuric on 9/25/16.
//  Copyright © 2016 Alphire Studios. All rights reserved.
//

import UIKit
import Firebase

class SignInController: UIViewController {
   
    
    lazy var exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "xIcon"), for: UIControlState())
        button.tintColor = STANDARD_ORANGE
        button.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    
    let logoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LogoAndName")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
        
    }()
    
    let referenceView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    
    let seperatorView1: UIView = {
        let view = UIView()
        view.backgroundColor = STANDARD_ORANGE
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    
    let seperatorView2: UIView = {
        let view = UIView()
        view.backgroundColor = STANDARD_ORANGE
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    
    let passwordIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PasswordIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    let emailIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "EmailIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    var emailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.clearButtonMode = UITextFieldViewMode.whileEditing
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
        
    }()
    
    var passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.clearButtonMode = UITextFieldViewMode.whileEditing
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
        
    }()

    lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = STANDARD_ORANGE
        button.setTitle("Sign In", for: UIControlState())
        button.titleLabel?.font = UIFont(name: STANDARD_FONT, size: 20)
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(signInButtonPressed), for: .touchUpInside)
        
        return button
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = UIColor.white
        
        self.hideKeyboardWhenTappedAround()
        
        view.addSubview(exitButton)
        setupExitButton()
        
        view.addSubview(referenceView)
        setupReferenceView()
        
        view.addSubview(logoImage)
        setupLogoImage()
        
        view.addSubview(inputsContainerView)
        setupInputsContainerView()
        
        view.addSubview(signInButton)
        setupSignInButton()
    }

    
    func signInButtonPressed() {
        
        view.endEditing(true)
        
        present(loadingIndicatorView, animated: true, completion: nil)
        
        if let email = emailField.text, let password = passwordField.text {
            
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                
                self.dismiss(animated: false, completion: {
                
                    if error != nil {
                        alertController.message = "Username or password is incorrect."
                        self.present(alertController, animated: true, completion: nil)
                        return
                    } else {
                        
                        DataService.dataService.setTabBarControllerAsRoot()
                        
                    }
                
                })
                    
            })

        }
        
    }
    
    
    func exitButtonPressed() {
        
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //***** Constraints *****//
    
    func setupExitButton() {
        
        exitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        exitButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5).isActive = true
        exitButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
        exitButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1).isActive = true
        
    }

    func setupReferenceView() {
        
        view.sendSubview(toBack: referenceView)
        
        referenceView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        referenceView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        referenceView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        referenceView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.37).isActive = true
    }
    
    
    func setupLogoImage() {
        
        logoImage.centerYAnchor.constraint(equalTo: referenceView.centerYAnchor).isActive = true
        logoImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        logoImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
        logoImage.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25/2).isActive = true
        
    }
    
    
    func setupInputsContainerView() {
        
        let leftMargin: CGFloat = 40.0
        let rightMargin: CGFloat = -7.0
        
        //Setup Container View
        inputsContainerView.topAnchor.constraint(equalTo: referenceView.bottomAnchor).isActive = true
        inputsContainerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        inputsContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        //Setup Email Field
        inputsContainerView.addSubview(emailField)
        
        emailField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        emailField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: rightMargin).isActive = true
        emailField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: leftMargin).isActive = true
        emailField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        //Setup Email Icon
        inputsContainerView.addSubview(emailIcon)
        
        emailIcon.centerYAnchor.constraint(equalTo: emailField.centerYAnchor).isActive = true
        emailIcon.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 0).isActive = true
        emailIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        emailIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        //Setup Seperator1
        inputsContainerView.addSubview(seperatorView1)
        
        seperatorView1.topAnchor.constraint(equalTo: emailField.bottomAnchor).isActive = true
        seperatorView1.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        seperatorView1.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        seperatorView1.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        
        //Setup Password Field
        inputsContainerView.addSubview(passwordField)
        
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor).isActive = true
        passwordField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: rightMargin).isActive = true
        passwordField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: leftMargin).isActive = true
        passwordField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0.5).isActive = true
        
        //Setup Password Icon
        inputsContainerView.addSubview(passwordIcon)
        
        passwordIcon.centerYAnchor.constraint(equalTo: passwordField.centerYAnchor).isActive = true
        passwordIcon.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 0).isActive = true
        passwordIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        passwordIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        //Setup Seperator2
        inputsContainerView.addSubview(seperatorView2)
        
        seperatorView2.topAnchor.constraint(equalTo: passwordField.bottomAnchor).isActive = true
        seperatorView2.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        seperatorView2.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        seperatorView2.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
    
    }
  
    func setupSignInButton() {
    
        signInButton.topAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 25).isActive = true
        signInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        signInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    }
}





