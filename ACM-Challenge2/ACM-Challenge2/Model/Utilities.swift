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
    textfield.layer.cornerRadius = 4.0
    textfield.layer.masksToBounds = true
    textfield.layer.borderColor = UIColor(displayP3Red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0).cgColor
    textfield.layer.borderWidth = 1.0
 }
}
