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
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var plusbutton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var formView: UIView!
    
    @IBOutlet weak var psLabel: UILabel!
    
    @IBOutlet weak var load: UIActivityIndicatorView!
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
        
        formView.layer.borderWidth = 2
        formView.layer.borderColor = UIColor(displayP3Red: 140/255, green: 148/255, blue: 159/255, alpha: 1.0).cgColor
        self.formView.layer.shadowPath =
              UIBezierPath(roundedRect: self.formView.bounds,
              cornerRadius: self.formView.layer.cornerRadius).cgPath
        self.formView.layer.shadowColor = UIColor.black.cgColor
        self.formView.layer.shadowOpacity = 0.5
        self.formView.layer.shadowOffset = CGSize(width: 1, height: 2)
        self.formView.layer.shadowRadius = 1
        self.formView.layer.masksToBounds = false
        super.viewDidLoad()
         NotificationCenter.default.addObserver(self,selector: #selector(refreshLbl),name:NSNotification.Name(rawValue: "refresh"),object: nil)
        getDate()
        Utilities.styleTextField(nameTextField)
        Utilities.styleTextField(birthdayTextField)
        Utilities.styleTextField(phoneTextField)
        print(latlong)
        locationLabel.text = ""
        errorLabel.alpha = 0
        psLabel.isHidden = true
        load.isHidden = true
    }
        
    
    
    @objc func refreshLbl() {
        locationLabel.text = "🏠 " + locationName
        plusbutton.tintColor = .green
        errorLabel.text = ""
        psLabel.isHidden = true
    }
    

    override func viewDidAppear(_ animated: Bool) {
        addButton.isEnabled = true
        print("profileVC appeared")
    }
    
    @IBAction func segmentValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            nameLabel.text = "Name 💁🏻‍♂️"
        case 1:
            nameLabel.text = "Name 💁🏼‍♀️"
        default:
            nameLabel.text = "Name 💁🏼‍♀️"
        }
    }
    
    
    func validateFields() -> String? {
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || birthdayTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
            psLabel.isHidden = true
            return "Please fill in all the fields"
        }
        if locationLabel.text == "" {
            psLabel.isHidden = false
            return "Please add your location"
        }
        psLabel.isHidden = true
        return nil
    }
    

    //MARK: - add data to firebase
    func addData() {
        //valudate fields
        if validateFields() != nil {
            self.showError(errorLabel, validateFields() ?? "error!")
        }
        else {
            load.isHidden = false
            load.startAnimating()
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
                locationName = ""
                NotificationCenter.default.post(name: Notification.Name("NewFunctionName"), object: nil)
                self.dismiss(animated: true, completion: nil)
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
    }
    
    @objc func viewTapped(gestureRecognizer : UITapGestureRecognizer){
        view.endEditing(true)
    }
    @objc func dateChanged(datepicker: UIDatePicker){
        birthdayTextField.text = dateFormatter.string(from: datePicker!.date)
        //x = String(dateFormatter.string(from: datePicker!.date))
    }
    
    func showError(_ label : UILabel, _ message : String){
        label.alpha = 1
        label.text = message
    }
}
