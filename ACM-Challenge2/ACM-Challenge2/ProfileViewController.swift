//
//  ProfileViewController.swift
//  ACM-Challenge2
//
//  Created by Aaryan Kothari on 20/03/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import UIKit
import FirebaseFirestore

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
//        let name = "aaryan"
//        let db = Firestore.firestore()
//        db.collection("users").addDocument(data: ["name":name]) { (error) in
//
//            if error != nil {
//                print("Error saving user info")
//            }
//            else {
//            print("Done")
//        }
//    }
}
    
    func validateFields() -> String? {
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || birthdayTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all the fields"
        }
        return nil
    }
    

    //MARK: - add data to firebase
    func addData() {
        //valudate fields
        if validateFields() != nil {
           // errorLabel.alpha = 1
            //self.showError(errorLabel, validateFields() ?? "error!")
        }
        else {
            //addButton.isEnabled = false
            //Data variables
            let name =  nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let birthday = birthdayTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let phone = phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let gender = genderSegmentedControl.selectedSegmentIndex
            let db = Firestore.firestore()
            db.collection("users").addDocument(data: ["name":name!,"birthday":birthday!,"phone":phone!,"gender":gender]) { (error) in
                
                if error != nil {
                    print("Error saving user info")
                }
                else {
                   // self.successAlert()
                print("Done")
                }
            }
        }
    }
    
    @IBAction func addButtonPushed(_ sender: Any) {
        addData()
    }
    
}
