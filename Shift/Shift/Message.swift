//
//  Message.swift
//  Shift
//
//  Created by Aleksandar Djuric on 10/21/16.
//  Copyright © 2016 Alphire Studios. All rights reserved.
//

import UIKit
import Firebase

class Message: NSObject {
    
    var sender: String?
    var recipient: String?
    var text: String?
    var timestamp: String?
    var messageRead: String = "false"
    var messageID: String?
    
    
    func formatTimeSent() -> String {
        
        var time: String?
        
        let secondsInADay: Double = 24*60*60
        let secondsInAWeek: Double = 7*secondsInADay
        
        let currentDate = Date()
        let cal = Calendar(identifier: .gregorian)
        let startOfDay = cal.startOfDay(for: currentDate).timeIntervalSince1970
        
        let startOfYesterday: TimeInterval = (startOfDay - secondsInADay)
        let startOfWeek: TimeInterval = (startOfDay - secondsInAWeek)
        
        
        if let timeMessageSentInSeconds = Double(timestamp!) {
            
            let date = Date(timeIntervalSince1970: timeMessageSentInSeconds)
            
            let dateFormatter = DateFormatter()
            
            if timeMessageSentInSeconds > startOfDay  {
                
                dateFormatter.dateFormat = "h:mm a"
                time = dateFormatter.string(from: date)
                
            } else if timeMessageSentInSeconds < startOfDay && timeMessageSentInSeconds >= startOfYesterday {
                time = "Yesterday"
                
            } else if timeMessageSentInSeconds < startOfYesterday && timeMessageSentInSeconds >= startOfWeek {
                
                dateFormatter.dateFormat = "EEEE"
                time = dateFormatter.string(from: date)
                
            } else if timeMessageSentInSeconds < startOfWeek {
                
                dateFormatter.dateFormat = "MMM dd, yyyy"
                time = dateFormatter.string(from: date)
                
            }
            
        }
        
        return time!
    }
    
    
    func chatPartnerID() -> String {
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        
        let chatPartnerID: String?
        
        if sender == uid {
            chatPartnerID = recipient!
        } else {
            chatPartnerID = sender!
        }
    
        return chatPartnerID!
    }
    
}
