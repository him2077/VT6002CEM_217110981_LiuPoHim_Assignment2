//
//  Utilities.swift
//  VT6002CEM_217110981_LiuPoHim_Assignment2
//
//  Created by user211668 on 1/4/22.
//

import Foundation
import UIKit

class Utilities {
    
    static func setTextFieldStyle(_ textField: UITextField, color: UIColor){
        let underLine : CALayer
        
        if(textField.borderStyle == .none){
            underLine = textField.layer.sublayers![0]
            underLine.backgroundColor = color.cgColor
        }
        else{
            underLine = CALayer()
            underLine.frame = CGRect(x: 0, y: textField.frame.height - 3, width: textField.frame.width, height: 3)
            
            underLine.backgroundColor = color.cgColor
            
            textField.borderStyle = .none
            
            textField.layer.addSublayer(underLine)
        }
        
        
    }
    
    static func setButtonStyle(_ button: UIButton){
        
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func CheckInputValid(_ Input: String) -> Bool{
        let limitation = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])[A-Za-z\\d$@$#!%*?&]{8,}")
        return limitation.evaluate(with: Input)
    }
}
