//
//  addContactViewController.swift
//  ACM-Challenge2
//
//  Created by Swamita on 24/03/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import UIKit
import Firebase

class addContactViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var DOBField: UITextField!
    
    private var datePicker: UIDatePicker?
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(addContactViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer( target: self, action: #selector(addContactViewController.viewTapped(gestureRecognizer: )))
        
        view.addGestureRecognizer(tapGesture)
            
        DOBField.inputView = datePicker

        // Do any additional setup after loading the view.
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        DOBField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    
    @IBAction func saveInfoPressed(_ sender: Any) {
        if let name = nameField.text, let email = emailField.text,
            let phone = phoneField.text, let DOB = DOBField.text {
            db.collection("forms").addDocument(data: [
                "Name": name,
                "Email": email,
                "Phone": phone,
                "DOB": DOB
            ]) { (error) in
                if let e=error {
                    print("Error: \(e)")
                } else {
                    print("Saved")
                }
            }
        }
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
