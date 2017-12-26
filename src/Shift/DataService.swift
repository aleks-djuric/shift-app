//
//  DataService.swift
//  Shift
//
//  Created by Aleksandar Djuric on 10/5/16.
//  Copyright © 2016 Alphire Studios. All rights reserved.
//

import Foundation
import Firebase

class DataService {
    
    static let dataService = DataService()
    
    var fileURL = String() //Generic variable for storing file URLs when needed
    
    //Declaring reference constants
    fileprivate var _DATABASE_REF = FIRDatabase.database().reference()
    fileprivate var _STORAGE_REF = FIRStorage.storage().reference()
    
    
    //Get functions
    var databaseRef: FIRDatabaseReference {
        return _DATABASE_REF
    }
    
    var storageRef: FIRStorageReference {
        return _STORAGE_REF
    }

    var usersRef: FIRDatabaseReference {
        return _DATABASE_REF.child("users")
    }
    
    var messagesRef: FIRDatabaseReference {
        return _DATABASE_REF.child("messages")
    } 
    
    
    func changeDisplayName(_ user: FIRUser, fullName: String) {
        
        let changeRequestDisplayName = user.profileChangeRequest()
        changeRequestDisplayName.displayName = fullName
        
        changeRequestDisplayName.commitChanges(completion: { (error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
        })
        
    }
    
    
    func addUserToDatabase(_ user: FIRUser, name: String, email: String) {
        
        let values = ["name" : name, "email" : email]
        usersRef.child(user.uid).updateChildValues(values)
        
    }
    
    
    func changeProfileImage(_ user: FIRUser, imageData: Data) {

        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        
        self.storageRef.child("profileImage/\(user.uid)").put(imageData, metadata: metadata, completion: { (metadata, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            self.fileURL = (metadata?.downloadURLs![0].absoluteString)!
            
            //Update Database
            self.usersRef.child(user.uid).updateChildValues(["profilePhotoURL" : self.fileURL])
            
            //Profile change
            let changeRequestProfilePhoto = user.profileChangeRequest()
            changeRequestProfilePhoto.photoURL = URL(string: self.fileURL)
            
            changeRequestProfilePhoto.commitChanges(completion: { (error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
            })
            
        })
        
    }

    
    func sendMessage(_ text: String, recipient: String) {
        
        let currentUser = FIRAuth.auth()?.currentUser;
        
        if let user = currentUser {
            
            let sender = user.uid
            
            let childRef = messagesRef.childByAutoId()
        
            let timestamp = String(Int(Date().timeIntervalSince1970))
            
            let messageRead = "false"
            
            let values = ["text": text, "timestamp": timestamp, "messageRead": messageRead, "recipient": recipient, "sender": sender]
        
            childRef.updateChildValues(values, withCompletionBlock: { (error, ref) in
                if error != nil {
                    print(error?.localizedDescription as Any)
                    return
                }
                
                let messageID = childRef.key
                
                let senderMessagesRef = FIRDatabase.database().reference().child("users_messages").child(sender).child(recipient)
                senderMessagesRef.updateChildValues([messageID: true])
                
                let recipientMessagesRef = FIRDatabase.database().reference().child("users_messages").child(recipient).child(sender)
                recipientMessagesRef.updateChildValues([messageID: true])
                
            })
            
        }
        
    }
    
    
    func setMessageToRead(_ messageID: String) {
        
        let messageRef = messagesRef.child(messageID)
        
        let values = ["messageRead": "true"]
        
        messageRef.updateChildValues(values)
        
    }
    
    
    func signOutUser() {
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        window?.rootViewController = FirstController()
        
    }
    
    
    var window: UIWindow?
    
    func setTabBarControllerAsRoot() {
        
        let tabBarController = UITabBarController()
        
        let viewControllers: [UIViewController]? = {
            
            let messagesNavController = UINavigationController(rootViewController: MessagesController())
            messagesNavController.tabBarItem = UITabBarItem(title: "Messages", image: UIImage(named: "MessagesIcon"), selectedImage: nil)
            
            let profileController = ProfileController()
            profileController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "UserIcon"), selectedImage: nil)
            
            let scheduleNavController = UINavigationController(rootViewController: ScheduleController())
            scheduleNavController.tabBarItem = UITabBarItem(title: "Schedule", image: UIImage(named: "ScheduleIcon"), selectedImage: nil)
            
            let newsFeedNavController = UINavigationController(rootViewController: NewsFeedController())
            newsFeedNavController.tabBarItem = UITabBarItem(title: "News Feed", image: UIImage(named: "NewsFeedIcon"), selectedImage: nil)
            
            return [newsFeedNavController, messagesNavController, scheduleNavController, profileController]
        }()
        
        tabBarController.viewControllers = viewControllers
        tabBarController.selectedIndex = 0
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        self.window?.rootViewController = tabBarController
        
    }

}

