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
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    //MARK: - Variables
    var name = String()
    var Gender = String()
    var Birthday = String()
    var phone = String()
    
    //MARK: - Date Variables
    var td1 : Date = Date()
    let dateFormatter = DateFormatter()
    private var datePicker : UIDatePicker?

    override func viewDidLoad() {
        super.viewDidLoad()
        getDate()
        print(latlong)
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        locationLabel.text = locationName
        addButton.isEnabled = true
    }
    
    func validateFields() -> String? {
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || birthdayTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            return "Please fill in all the fields"
        }
        if locationLabel.text == "" {
            return "Please add location"
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
            addButton.isEnabled = false
            //Data variables
            let name =  nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let birthday = birthdayTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let phone = phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let gender = genderSegmentedControl.selectedSegmentIndex
            let latitude = String(latlong[0])
            let longitude = String(latlong[1])
            let cityName = city
            let stateName = state
            let countryName = country
            let db = Firestore.firestore()
            db.collection("users").addDocument(data: ["name":name!,"birthday":birthday!,"phone":phone!,"gender":gender,"lat":latitude,"long":longitude,"city":cityName,"state":stateName,"country":countryName]) { (error) in
                
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
    
    @IBAction func addButtonPushed(_ sender: UIButton) {
        addData()
    }
    
    
    
    //MARK: - Date picker functions
    func getDate(){
        dateFormatter.dateFormat = "dd/MM/YYYY"

        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged(datepicker:)) , for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer :)))
        view.addGestureRecognizer(tapGesture)
        birthdayTextField.inputView = datePicker
        locationLabel.text = locationName
    }
    
    @objc func viewTapped(gestureRecognizer : UITapGestureRecognizer){
        view.endEditing(true)
    }
    @objc func dateChanged(datepicker: UIDatePicker){
        birthdayTextField.text = dateFormatter.string(from: datePicker!.date)
        //x = String(dateFormatter.string(from: datePicker!.date))
    }
}
