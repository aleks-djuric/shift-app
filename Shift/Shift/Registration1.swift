//
//  Registration1.swift
//  Shift
//
//  Created by Aleksandar Djuric on 9/22/16.
//  Copyright © 2016 Alphire Studios. All rights reserved.
//

import UIKit
import Navajo_Swift
import Firebase

class Registration1: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let referenceView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var chooseProfileImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "TemporaryProfileImage"))
        imageView.tintColor = STANDARD_ORANGE
        imageView.contentMode = .scaleAspectFill
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseProfileImagePressed)))
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = (UIScreen.main.bounds.size.width)*(0.30/2)
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var imagePicked = false
    
    let inputsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    //Full Name Section Objects
    lazy var fullNameField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Full Name"
        textField.clearButtonMode = UITextFieldViewMode.whileEditing
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 1
        
        textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        
        return textField
    }()
    
    let userIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "UserIcon")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let fullNameCheckmark: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    
    let seperatorView1: UIView = {
        let view = UIView()
        view.backgroundColor = STANDARD_ORANGE
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    //Email Section Objects
    lazy var emailField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.clearButtonMode = UITextFieldViewMode.whileEditing
        textField.keyboardType = .emailAddress
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 2
        
        textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        
        return textField
    }()
    
    let emailIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "EmailIcon")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var emailCheckmark: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    
    let seperatorView2: UIView = {
        let view = UIView()
        view.backgroundColor = STANDARD_ORANGE
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()

    //Password Section Objects
    lazy var passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.clearButtonMode = UITextFieldViewMode.whileEditing
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 3
        
        textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)
        
        return textField
    }()
    
    let passwordIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "PasswordIcon")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var passwordCheckmark: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var passwordErrorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: STANDARD_FONT, size: 10.0)
        label.textColor = UIColor.red
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let seperatorView3: UIView = {
        let view = UIView()
        view.backgroundColor = STANDARD_ORANGE
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    //Confirm Password Section Objects
    lazy var confirmPasswordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Confirm Password"
        textField.clearButtonMode = UITextFieldViewMode.whileEditing
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 4
        
        textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControlEvents.editingChanged)

        return textField
    }()
    
    let confirmPasswordIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ConfirmPasswordIcon")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var confirmPasswordCheckmark: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    
    let seperatorView4: UIView = {
        let view = UIView()
        view.backgroundColor = STANDARD_ORANGE
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    

    let rightBarButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonPressed))
        
    override func viewDidLoad() {
        super.viewDidLoad()
  
        view.backgroundColor = UIColor.white
        
        self.title = "Register"
        
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed))
        leftBarButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: STANDARD_FONT, size: 15)!], for: UIControlState())
        leftBarButton.tintColor = STANDARD_ORANGE
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        rightBarButton.isEnabled = false
        rightBarButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: STANDARD_FONT, size: 15)!], for: UIControlState())
        rightBarButton.tintColor = STANDARD_ORANGE
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        self.hideKeyboardWhenTappedAround()
        
        view.addSubview(referenceView)
        setupReferenceView()
        
        view.addSubview(chooseProfileImageView)
        setupChooseProfileImageButton()
        
        view.addSubview(inputsContainerView)
        setupInputsContainerView()
    
    }
    

    func cancelButtonPressed() {
        
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    func nextButtonPressed() {

        //Check if user chose a profile image
        if imagePicked {
            
            self.present(loadingIndicatorView, animated: true, completion: nil) //Calls "please wait" view controller
            
            //Attempt to create new user
            FIRAuth.auth()?.createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
                
                //Check for error. If found alert user and cancel sign up process.
                if let error = error {
                    self.dismiss(animated: false, completion: {     //Dismisses "please wait" view controller
                        alertController.message = error.localizedDescription
                        self.present(alertController, animated: true, completion: nil)
                        return
                    })
                //Otherwise, continue with sign up process
                } else {
                    self.view.endEditing(true)
                    
                    DataService.dataService.addUserToDatabase(user!, name: self.fullNameField.text!, email: self.emailField.text!)
                    DataService.dataService.changeDisplayName(user!, fullName: self.fullNameField.text!)
                    if let profileImage = self.chooseProfileImageView.image, let imageData = UIImageJPEGRepresentation(profileImage, 0.1) {
                        DataService.dataService.changeProfileImage(user!, imageData: imageData)
                    }
                    FIRAuth.auth()?.signIn(withEmail: self.emailField.text!, password: self.passwordField.text!, completion: nil)
                    DataService.dataService.setTabBarControllerAsRoot()
                    
                    self.dismiss(animated: false, completion: nil)
                }
                
            })
            
        //If user did not chose a profile image, alert them that they must
        } else {
            alertController.message = "Please choose a profile image."
            self.present(alertController, animated: true, completion: nil)
            
        }
        
    }
    
    
    func chooseProfileImagePressed() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            chooseProfileImageView.image = selectedImage
            imagePicked = true
        }
        
        
        
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func textFieldDidChange(_ textField: UITextField) {
        
        switch textField.tag {
            
        case 1:
            let result = checkForValidFullName(textField)
            
            if result {
                fullNameCheckmark.image = UIImage(named: "GreenCheckmark")
            } else {
                fullNameCheckmark.image = nil
            }
            
        case 2:
            let result = checkForValidEmail(textField)
            
            if result {
                emailCheckmark.image = UIImage(named: "GreenCheckmark")
            } else {
                emailCheckmark.image = nil
            }
            
        case 3:
            if checkForValidPassword(textField) == "" {
                passwordCheckmark.image = UIImage(named: "GreenCheckmark")
                passwordErrorLabel.text = ""
            } else {
                if passwordField.text == "" {
                    passwordErrorLabel.text = ""
                    passwordCheckmark.image = nil
                } else {
                    passwordErrorLabel.text = checkForValidPassword(textField)
                    passwordCheckmark.image = nil
                }
            }
            
        case 4:
            if textField.text == passwordField.text && passwordCheckmark.image != nil {
                confirmPasswordCheckmark.image = UIImage(named: "GreenCheckmark")
            } else {
                confirmPasswordCheckmark.image = nil
            }
            
        default:
            return
        }
        
        if fullNameCheckmark.image != nil && emailCheckmark.image != nil && confirmPasswordCheckmark.image != nil {
                rightBarButton.isEnabled = true
        }
        
    }
    
    
    func checkForValidFullName(_ textField: UITextField) -> Bool {
        
        let fullNameRegEx = "[A-Za-z]+\\s+[A-Za-z\\s]+"
        let range = textField.text!.range(of: fullNameRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        
        return result
    }
    
    
    func checkForValidEmail(_ textField: UITextField) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let range = textField.text!.range(of: emailRegEx, options:.regularExpression)
        let result = range != nil ? true : false
        
        return result
    }
    
    
    func checkForValidPassword(_ textField: UITextField) -> String {
            
        let lengthRule = NJOLengthRule(min: 6, max: 24)
        let lowercaseRule = NJORequiredCharacterRule(preset: .lowercaseCharacter)
        let uppercaseRule = NJORequiredCharacterRule(preset: .uppercaseCharacter)
        let decimalRule = NJORequiredCharacterRule(preset: .decimalDigitCharacter)
        
        let validator = NJOPasswordValidator(rules: [lengthRule, lowercaseRule, decimalRule, uppercaseRule])
        
        let failingRules = validator.validate(textField.text!)
        
        if failingRules == nil {
            return ""
            
        } else {
            return failingRules![0].localizedErrorDescription
            
        }

    }
    
    
    //****Constraints*****//
    
    func setupReferenceView() {
        
        view.sendSubview(toBack: referenceView)
        
        referenceView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        referenceView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        referenceView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        referenceView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.33).isActive = true
    }
    
    func setupChooseProfileImageButton() {
        
        chooseProfileImageView.topAnchor.constraint(equalTo: referenceView.centerYAnchor, constant: -20).isActive = true
        chooseProfileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        chooseProfileImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        chooseProfileImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        
    }
    
    
    func setupInputsContainerView() {
        
        let leftMargin: CGFloat = 40.0
        let rightMargin: CGFloat = -7.0
        
        //Setup Container View
        inputsContainerView.topAnchor.constraint(equalTo: referenceView.bottomAnchor).isActive = true
        inputsContainerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        inputsContainerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        inputsContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.30).isActive = true
        
        //Setup Full Name Field
        inputsContainerView.addSubview(fullNameField)
        
        fullNameField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor).isActive = true
        fullNameField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: leftMargin).isActive = true
        fullNameField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: rightMargin).isActive = true
        fullNameField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0.25).isActive = true
        
        //Setup User Icon
        inputsContainerView.addSubview(userIcon)
        
        userIcon.centerYAnchor.constraint(equalTo: fullNameField.centerYAnchor).isActive = true
        userIcon.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        userIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        userIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //Setup Full Name Checkmark
        inputsContainerView.addSubview(fullNameCheckmark)
        
        fullNameCheckmark.centerYAnchor.constraint(equalTo: fullNameField.centerYAnchor).isActive = true
        fullNameCheckmark.leftAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: 15).isActive = true
        fullNameCheckmark.widthAnchor.constraint(equalToConstant: 20).isActive = true
        fullNameCheckmark.heightAnchor.constraint(equalToConstant: 20).isActive = true

        
        //Setup Seperator 1
        inputsContainerView.addSubview(seperatorView1)
        
        seperatorView1.topAnchor.constraint(equalTo: fullNameField.bottomAnchor).isActive = true
        seperatorView1.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        seperatorView1.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        seperatorView1.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        
        //Setup Email Field
        inputsContainerView.addSubview(emailField)
        
        emailField.topAnchor.constraint(equalTo: fullNameField.bottomAnchor).isActive = true
        emailField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: rightMargin).isActive = true
        emailField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: leftMargin).isActive = true
        emailField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0.25).isActive = true
        
        //Setup Email Icon
        inputsContainerView.addSubview(emailIcon)
        
        emailIcon.centerYAnchor.constraint(equalTo: emailField.centerYAnchor).isActive = true
        emailIcon.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        emailIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        emailIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //Setup Email Checkmark
        inputsContainerView.addSubview(emailCheckmark)
        
        emailCheckmark.centerYAnchor.constraint(equalTo: emailField.centerYAnchor).isActive = true
        emailCheckmark.leftAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: 15).isActive = true
        emailCheckmark.widthAnchor.constraint(equalToConstant: 20).isActive = true
        emailCheckmark.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //Setup Seperator 2
        inputsContainerView.addSubview(seperatorView2)
        
        seperatorView2.topAnchor.constraint(equalTo: emailField.bottomAnchor).isActive = true
        seperatorView2.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        seperatorView2.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        seperatorView2.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        
        //Setup Password Field
        inputsContainerView.addSubview(passwordField)
        
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor).isActive = true
        passwordField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: rightMargin).isActive = true
        passwordField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: leftMargin).isActive = true
        passwordField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0.25).isActive = true
        
        //Setup Password Icon
        inputsContainerView.addSubview(passwordIcon)
        
        passwordIcon.centerYAnchor.constraint(equalTo: passwordField.centerYAnchor).isActive = true
        passwordIcon.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        passwordIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        passwordIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //Setup Password Checkmark
        inputsContainerView.addSubview(passwordCheckmark)
        
        passwordCheckmark.centerYAnchor.constraint(equalTo: passwordField.centerYAnchor).isActive = true
        passwordCheckmark.leftAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: 15).isActive = true
        passwordCheckmark.widthAnchor.constraint(equalToConstant: 20).isActive = true
        passwordCheckmark.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //Setup Password Error Label
        inputsContainerView.addSubview(passwordErrorLabel)
        
        passwordErrorLabel.leftAnchor.constraint(equalTo: passwordField.leftAnchor).isActive = true
        passwordErrorLabel.rightAnchor.constraint(equalTo: passwordField.rightAnchor).isActive = true
        passwordErrorLabel.bottomAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: -2.0).isActive = true
        passwordErrorLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        //Setup Seperator 3
        inputsContainerView.addSubview(seperatorView3)
        
        seperatorView3.topAnchor.constraint(equalTo: passwordField.bottomAnchor).isActive = true
        seperatorView3.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        seperatorView3.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        seperatorView3.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        
        //Setup Confirm Password Field
        inputsContainerView.addSubview(confirmPasswordField)
        
        confirmPasswordField.topAnchor.constraint(equalTo: passwordField.bottomAnchor).isActive = true
        confirmPasswordField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: leftMargin).isActive = true
        confirmPasswordField.rightAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: rightMargin).isActive = true
        confirmPasswordField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 0.25).isActive = true
        
        //Setup Confirm Password Icon
        inputsContainerView.addSubview(confirmPasswordIcon)
        
        confirmPasswordIcon.centerYAnchor.constraint(equalTo: confirmPasswordField.centerYAnchor).isActive = true
        confirmPasswordIcon.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        confirmPasswordIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        confirmPasswordIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //Setup Confirm Password Checkmark
        inputsContainerView.addSubview(confirmPasswordCheckmark)
        
        confirmPasswordCheckmark.centerYAnchor.constraint(equalTo: confirmPasswordField.centerYAnchor).isActive = true
        confirmPasswordCheckmark.leftAnchor.constraint(equalTo: inputsContainerView.rightAnchor, constant: 15).isActive = true
        confirmPasswordCheckmark.widthAnchor.constraint(equalToConstant: 20).isActive = true
        confirmPasswordCheckmark.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        //Setup Seperator 4
        inputsContainerView.addSubview(seperatorView4)
        
        seperatorView4.topAnchor.constraint(equalTo: confirmPasswordField.bottomAnchor).isActive = true
        seperatorView4.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor).isActive = true
        seperatorView4.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        seperatorView4.heightAnchor.constraint(equalToConstant: 1.5).isActive = true
        
    }

}


