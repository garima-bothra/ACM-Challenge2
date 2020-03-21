//
//  ShowProfileDataViewController.swift
//  ACM-Challenge2
//
//  Created by Aaryan Kothari on 20/03/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import UIKit
import MapKit

class ShowProfileDataViewController: UIViewController{
    
    //MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - Variables
    var name : String = ""
    var birthday : String = ""
    var phone : String = ""
    var latitude : String = ""
    var longitude : String = ""
    var city : String = ""
    var state : String = ""
    var country : String = ""
    var gender : String = ""

    let genders = ["Male","Female","Unknown"]

    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        self.navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        setUpLabels()
        setupMap()
        
        }
    
    
    func setUpLabels(){
        let 🌎 = Countries.setEmoji(country)
        
        nameLabel.text = name
        phoneLabel.text = phone
        birthdayLabel.text = birthday
        genderLabel.text = genders[Int(gender) ?? 2]
        locationLabel.text = "\(city),  \(state)"
        countryLabel.text = 🌎 + " " + country.capitalized
    }
    
    
    func setupMap(){
        let firstName = name.components(separatedBy: " ")[0]
        
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(Double(latitude)!, Double(longitude)!)
        let region : MKCoordinateRegion = MKCoordinateRegion(center: location,span: span)
        mapView.setRegion(region, animated: true)
        
        
        //MARK:- annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "\(firstName)'s home"
        annotation.subtitle = "\(city),\(state)"
        mapView.addAnnotation(annotation)
    }
}
