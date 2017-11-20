//
//  Universals.swift
//  Shift
//
//  Created by Aleksandar Djuric on 9/21/16.
//  Copyright © 2016 Alphire Studios. All rights reserved.
//

import UIKit

let STANDARD_ORANGE = UIColor(r: 251, g: 121, b: 37)    //Hex: FB7925
let STANDARD_ORANGE_LIGHT = UIColor(colorLiteralRed: 251/255, green: 121/255, blue: 37/255, alpha: 0.5)
let STANDARD_BLUE = UIColor(r: 181, g: 201, b: 212)     //Hex: b5c9d4
let LIGHT_GRAY = UIColor(r: 230, g: 230, b: 230)

let STANDARD_FONT = "Avenir-Light"
let STANDARD_FONT_BOLD = "Avenir-Medium"


let alertController: UIAlertController = {
    let alert = UIAlertController(title: "Oops!", message: nil, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(okAction)
    
    return alert
}()


var loadingIndicatorView: UIAlertController = {
    let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    
    alert.view.tintColor = UIColor.black
    let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
    loadingIndicator.hidesWhenStopped = true
    loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
    loadingIndicator.startAnimating();
    
    alert.view.addSubview(loadingIndicator)
    
    return alert
}()






















