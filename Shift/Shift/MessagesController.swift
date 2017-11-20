//
//  MessagesTabController.swift
//  Shift
//
//  Created by Aleksandar Djuric on 9/20/16.
//  Copyright © 2016 Alphire Studios. All rights reserved.
//

import UIKit
import Firebase

class MessagesController: UITableViewController {

    let currentUID = FIRAuth.auth()?.currentUser?.uid
    let cellID = "MessagePreviewCell"
    
    var currentContacts = [String : Contact]()
    var lastMessages = [Message]()
    var lastMessagesDictionary = [String : Message]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        navBarTitleLabel.font = UIFont(name: STANDARD_FONT_BOLD, size: 20)
        navBarTitleLabel.textAlignment = .center
        navBarTitleLabel.text = "Messages"
        self.navigationItem.titleView = navBarTitleLabel
        
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(composeButtonPressed))
        rightBarButton.tintColor = STANDARD_ORANGE
        self.navigationItem.rightBarButtonItem = rightBarButton
        
        tableView.register(MessagePreviewCell.self, forCellReuseIdentifier: cellID)
        tableView.delegate = self
        
        loadMessages()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    func loadMessages() {
        
        let userMessagesRef = FIRDatabase.database().reference().child("users_messages").child(currentUID!)
        
        userMessagesRef.observe(.childAdded, with: { snapshot in
            
            let contactsMessagesRef = FIRDatabase.database().reference().child("users_messages").child(self.currentUID!).child(snapshot.key)
            
            contactsMessagesRef.observe(.childAdded, with: { snapshot in
                
                let messageID = snapshot.key
                
                let messagesRef = FIRDatabase.database().reference().child("messages").child(messageID)
                
                messagesRef.observeSingleEvent(of: .value , with: { snapshot in
                    
                    if let dictionary = snapshot.value as? [String: AnyObject] {
                        let message = Message()
                        
                        message.recipient = dictionary["recipient"] as! String?
                        message.sender = dictionary["sender"] as! String?
                        message.text = dictionary["text"] as! String?
                        message.timestamp = dictionary["timestamp"] as! String?
                        message.messageRead = (dictionary["messageRead"] as! String?)!
                        message.messageID = messageID
                        
                        if message.sender == self.currentUID {
                            self.lastMessagesDictionary[message.recipient!] = message
                        } else {
                            self.lastMessagesDictionary[message.sender!] = message
                        }
                        
                        self.timer?.invalidate()
                        self.timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.reloadTable), userInfo: nil, repeats: false)
                        
                    }
                    
                })
                
            })
            
        })
        
    }
    
    
    var timer: Timer?
    
    func reloadTable() {
        
        self.lastMessages = Array(self.lastMessagesDictionary.values)
        self.lastMessages.sort(by: {(message1,message2) -> Bool in
            return Int(message1.timestamp!)! > Int(message2.timestamp!)!
        })
        
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })
        
    }
    
    
    func composeButtonPressed() {
        
        let composeMessageController = ComposeMessageController()
        composeMessageController.messagesController = self
        let composeMessageNavController = UINavigationController(rootViewController: composeMessageController)
        present(composeMessageNavController, animated: true, completion: nil)
        
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if lastMessages.count != 0 {
            tableView.separatorStyle = .none
            tableView.backgroundView = nil
        }
        return lastMessages.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MessagePreviewCell
        
        let message = lastMessages[(indexPath as NSIndexPath).row]
        
        let chatPartnerID = message.chatPartnerID()
        
        FIRDatabase.database().reference().child("users").child(chatPartnerID).observeSingleEvent(of: .value, with: { snapshot in
            
            if let dictionary = snapshot.value as? [String : AnyObject] {
                
                let contact = Contact()
                contact.name = dictionary["name"] as! String?
                contact.UID = snapshot.key
                contact.profileImageURL = dictionary["profilePhotoURL"] as! String?
                self.currentContacts[contact.UID!] =  contact
                
                
                cell.contactNameLabel.text = contact.name
                cell.lastMessageLabel.text = message.text
                cell.timeOfLastMessage.text = message.formatTimeSent()

                if message.messageRead == "true" || message.sender == self.currentUID {
                    cell.verticalSeperator.backgroundColor = UIColor.clear
                }
                    
                if let profileImageURL = contact.profileImageURL {
                    cell.profileImage.loadImagesUsingCacheWithURLString(profileImageURL)
                }

            }
            
        })
        
        return cell
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let message = lastMessages[(indexPath as NSIndexPath).row]
        
        DataService.dataService.setMessageToRead(message.messageID!)
        message.messageRead = "true"

        let cell = tableView.cellForRow(at: indexPath) as! MessagePreviewCell
        
        cell.verticalSeperator.backgroundColor = UIColor.clear

        tableView.reloadRows(at: [indexPath], with: .fade)
        
        let chatPartnerID = message.chatPartnerID()
        
        if let contactToShow = currentContacts[chatPartnerID] {
            
            self.tableView.deselectRow(at: indexPath, animated: true)
            
            showChatControllerForContact(contactToShow)
            
        }
        
    }

    
    func showChatControllerForContact(_ contact: Contact) {
        
        let chatController = ChatController(collectionViewLayout: UICollectionViewFlowLayout())
        chatController.contact = contact
        navigationController?.pushViewController(chatController, animated: true)
        
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}








