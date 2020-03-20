//
//  ProfileViewController.swift
//  ACM-Challenge2
//
//  Created by Aaryan Kothari on 20/03/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    //MARK: - Variables
    var name = String()
    var Gender = String()
    var Birthday = Date()
    var phone = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
