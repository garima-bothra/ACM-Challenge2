//
//  Utilities.swift
//  ACM-Challenge2
//
//  Created by Aaryan Kothari on 20/03/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
static func styleTextField(_ textfield:UITextField) {

// Create the bottom line
let bottomLine = CALayer()
bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 7, width: textfield.frame.width, height: 2)
bottomLine.backgroundColor = UIColor.init(red: 215/255, green: 106/255, blue: 138/255, alpha: 1).cgColor
textfield.borderStyle = .none
// Add the line to the text field
textfield.layer.addSublayer(bottomLine)
 }
}
