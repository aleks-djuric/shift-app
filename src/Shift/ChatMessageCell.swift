//
//  ChatMessageCell.swift
//  Shift
//
//  Created by Aleksandar Djuric on 11/3/16.
//  Copyright © 2016 Alphire Studios. All rights reserved.
//

import UIKit

class ChatMessageCell: UICollectionViewCell {

    var messageText: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: STANDARD_FONT, size: 16)
        textView.textColor = UIColor.white
        textView.backgroundColor = UIColor.clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        return textView
    }()
    
    let messageBubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = STANDARD_ORANGE
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 17
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    var bubbleWidthAnchor: NSLayoutConstraint?
    var bubbleAnchoredToRight: NSLayoutConstraint?
    var bubbleAnchoredToLeft: NSLayoutConstraint?
    var anchor: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(messageBubbleView)
        contentView.addSubview(messageText)
        
        setupSubviews()
    }
    
    
    func setupSubviews() {
        
        //Setup Profile Image View
        
        profileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        profileImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 34).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        //Setup Message Bubble View
        
        messageBubbleView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        messageBubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        bubbleAnchoredToRight = messageBubbleView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10)
        bubbleAnchoredToRight?.isActive = true
        bubbleAnchoredToLeft = messageBubbleView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10)
        
        bubbleWidthAnchor = messageBubbleView.widthAnchor.constraint(equalToConstant: 0)
        
        //Setup Message Text
        
        messageText.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        messageText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        messageText.leftAnchor.constraint(equalTo: messageBubbleView.leftAnchor, constant: 5).isActive = true
        messageText.rightAnchor.constraint(equalTo: messageBubbleView.rightAnchor, constant: -5).isActive = true
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
