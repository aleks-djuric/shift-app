//
//  ComposeMessageController.swift
//  Shift
//
//  Created by Aleksandar Djuric on 10/15/16.
//  Copyright © 2016 Alphire Studios. All rights reserved.
//

import UIKit
import Firebase

class ComposeMessageController: UITableViewController {

    let cellID = "ChooseContactCell"
    
    var contacts = [Contact]()
    
    var messagesController = MessagesController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        let navBarTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        navBarTitleLabel.font = UIFont(name: STANDARD_FONT_BOLD, size: 20)
        navBarTitleLabel.textAlignment = .center
        navBarTitleLabel.text = "New Message"
        self.navigationItem.titleView = navBarTitleLabel
        
        let leftBarButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonPressed))
        leftBarButton.setTitleTextAttributes([NSFontAttributeName: UIFont(name: STANDARD_FONT, size: 15)!], for: UIControlState())
        leftBarButton.tintColor = STANDARD_ORANGE
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        tableView.register(ChooseContactCell.self, forCellReuseIdentifier: cellID)
        
        fetchContact()
    }

    func cancelButtonPressed() {
    
        view.endEditing(true)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func fetchContact() {
        
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { snapshot in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                
                let contact = Contact()
                
                contact.name = dictionary["name"] as! String?
                contact.UID = snapshot.key
                contact.profileImageURL = dictionary["profilePhotoURL"] as! String?
                
                if contact.UID != FIRAuth.auth()?.currentUser?.uid {
                    self.contacts.append(contact)
                }
                
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
                
            }
            
        })
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if contacts.count != 0 {
            tableView.separatorStyle = .none
            tableView.backgroundView = nil
        }
        return contacts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ChooseContactCell
        
        let contact = contacts[(indexPath as NSIndexPath).row]
        
        cell.contactNameLabel.text = contact.name
        
        if let profileImageURL = contact.profileImageURL {
            cell.profileImage.loadImagesUsingCacheWithURLString(profileImageURL)
        }
        
        return cell
    }

    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            self.messagesController.showChatControllerForContact(self.contacts[indexPath.row])
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}








