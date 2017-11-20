//
//  ChatController.swift
//  Shift
//
//  Created by Aleksandar Djuric on 10/14/16.
//  Copyright © 2016 Alphire Studios. All rights reserved.
//

import UIKit
import Firebase

class ChatController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {

    let cellID = "MessageBubbleCell"
    var currentMessages = [Message]()
    
    var contact: Contact? {
        didSet {
            let navBarTitleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
            navBarTitleLabel.font = UIFont(name: STANDARD_FONT_BOLD, size: 20)
            navBarTitleLabel.textAlignment = .center
            navBarTitleLabel.text = contact?.name
            self.navigationItem.titleView = navBarTitleLabel
            
            DispatchQueue.main.async(execute: {
                self.loadMessages()
            })

        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.leftBarButtonItem?.tintColor = STANDARD_ORANGE
        
        collectionView?.backgroundColor = UIColor.white
        self.tabBarController?.tabBar.isHidden = true
        collectionView?.alwaysBounceVertical = true
        edgesForExtendedLayout = []
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView?.register(ChatMessageCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView?.keyboardDismissMode = .interactive
        //setupKeyboardObservers()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        scrollToBottom()
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override var inputAccessoryView: UIView? {
        get {
            return inputComponentsContainerView
        }
    }
    
    
    override var canBecomeFirstResponder: Bool {
        return true
    }

    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        
    }
    
    
    func handleKeyboardWillShow(notification: NSNotification) {
        scrollToBottom()
    }
    
    
    func handleKeyboardWillHide(notification: NSNotification) {

    }
    
    
    func sendPressed() {
        
        if inputTextfield.text != "" {
            DataService.dataService.sendMessage(inputTextfield.text!, recipient: (contact?.UID)!)
            inputTextfield.text = ""
            
            scrollToBottom()
            
            DispatchQueue.main.async(execute: {
                self.collectionView?.reloadData()
            })
            
        }
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentMessages.count
    }

    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ChatMessageCell
        
        let message = currentMessages[indexPath.row]
        
        cell.messageText.text = message.text!
        
        if let profileImageURL = contact?.profileImageURL {
            cell.profileImageView.loadImagesUsingCacheWithURLString(profileImageURL)
        }
        
        setupCell(cell: cell, message: message)
        
        return cell
    }
    
    
    func setupCell(cell: ChatMessageCell, message: Message) {
        
        if message.sender == FIRAuth.auth()?.currentUser?.uid {
            cell.messageBubbleView.backgroundColor = STANDARD_ORANGE
            cell.messageText.textColor = UIColor.white
            cell.bubbleAnchoredToLeft?.isActive = false
            cell.bubbleAnchoredToRight?.isActive = true
            cell.profileImageView.image = nil
        } else {
            cell.messageBubbleView.backgroundColor = UIColor(r: 240, g: 240, b: 240)
            cell.messageText.textColor = UIColor.black
            cell.bubbleAnchoredToRight?.isActive = false
            cell.bubbleAnchoredToLeft?.isActive = true
        }
        
        cell.bubbleWidthAnchor?.constant = estimateFrameForText(text: message.text!).width + 25
        cell.bubbleWidthAnchor?.isActive = true
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat?
        
        if let text = currentMessages[indexPath.item].text {
            
            height = 1.20 * (estimateFrameForText(text: text).height + 10)
            
        }
        
        return CGSize(width: view.frame.width, height: height!)
    }
    
    
    func estimateFrameForText(text: String) -> CGRect {
        
        let size = CGSize(width: CGFloat(0.7 * view.frame.width), height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)], context: nil)

    }
    
    
    func loadMessages() {
        
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            return
        }
        
        let usersMessagesRef = FIRDatabase.database().reference().child("users_messages").child(uid).child((contact?.UID)!)
        
        usersMessagesRef.observe(.childAdded, with: { snapshot in
            
            let messageID = snapshot.key
            
            let messagesRef = FIRDatabase.database().reference().child("messages").child(messageID)
            
            messagesRef.observeSingleEvent(of: .value, with: { snapshot in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    let message = Message()
                    
                    message.recipient = dictionary["recipient"] as! String?
                    message.sender = dictionary["sender"] as! String?
                    message.text = dictionary["text"] as! String?
                    message.timestamp = dictionary["timestamp"] as! String?
                    
                    self.currentMessages.append(message)
                    
                    DispatchQueue.main.async(execute: {
                        self.collectionView?.reloadData()
                    })
                    
                }
                
            })
            
        })
        
    }
    
    
    lazy var inputTextfield: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Type a message..."
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.delegate = self
        
        return textfield
    }()
    
    var containerViewBottomAnchor: NSLayoutConstraint?
    
    let inputContainerViewHeight: CGFloat = 50.0
    
    //Initialize and Setup Inputs Container View
    lazy var inputComponentsContainerView: UIView = {
        
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.frame = CGRect(x: 0, y: 0, width: containerView.frame.width, height: self.inputContainerViewHeight)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        //Setup Send Button
        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.titleLabel?.font = UIFont(name: STANDARD_FONT, size: 18)
        sendButton.setTitleColor(STANDARD_ORANGE, for: .normal)
        sendButton.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(sendButton)
        
        sendButton.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        sendButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        sendButton.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        //Setup Input Textfield
        containerView.addSubview(self.inputTextfield)
        
        self.inputTextfield.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 10).isActive = true
        self.inputTextfield.rightAnchor.constraint(equalTo: sendButton.leftAnchor).isActive = true
        self.inputTextfield.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        self.inputTextfield.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        
        //Setup Seperator
        let seperator = UIView()
        seperator.backgroundColor = UIColor.lightGray
        seperator.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(seperator)
        
        seperator.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        seperator.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        seperator.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        return containerView
    }()
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendPressed()
        return true
    }
    
    func scrollToBottom() {
        let lastItemIndex = (collectionView?.numberOfItems(inSection: 0))! - 1
        let indexPath = IndexPath(item: lastItemIndex, section: 0)
        
        if lastItemIndex > 0 {
            collectionView!.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.bottom, animated: false)
        }
        
    }
    
}

