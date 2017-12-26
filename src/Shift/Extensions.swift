//
//  Extensions.swift
//  Shift
//
//  Created by Aleksandar Djuric on 10/14/16.
//  Copyright © 2016 Alphire Studios. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
}


extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
}


extension Date
{
    
    func dateAt(hours: Int, minutes: Int) -> Date
    {
        let calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        //get the month/day/year componentsfor today's date.
        
        
        var date_components = calendar.components(
            [NSCalendar.Unit.year,
             NSCalendar.Unit.month,
             NSCalendar.Unit.day],
            from: self)
        
        //Create an NSDate for the specified time today.
        date_components.hour = hours
        date_components.minute = minutes
        date_components.second = 0
        
        let newDate = calendar.date(from: date_components)!
        return newDate
    }
    
}


let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImagesUsingCacheWithURLString(_ urlString: String){
        
        self.image = nil
        
        let urlNSString = urlString as NSString!
        
        //If the image is already cached, use it and return
        if let cachedImage = imageCache.object(forKey: urlNSString!) as UIImage? {
            self.image = cachedImage
            return
        }
        
        //Otherwise cached the image before using it
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
            }
            
            DispatchQueue.main.async(execute: {
                
                if let downloadedImage = UIImage(data: data!) {
                    
                    imageCache.setObject(downloadedImage, forKey: urlNSString!)
                    
                    self.image = downloadedImage
                }
                
            })
            
        }).resume()
        
    }
    
}
