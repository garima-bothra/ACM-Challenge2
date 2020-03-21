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

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    @IBOutlet weak var phoneLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
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
    
    var numberOfDays = 0
    
    
    var genders = ["Male","Female","Unknown"]

    override func viewDidLoad() {
        
        
        var countries: [String] = []

        for code in NSLocale.isoCountryCodes  {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            countries.append(name)
        }

        print(countries)
        
        print(latitude,longitude,"latlong")
        print(city,country,"city")
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        setupMap()
        nameLabel.text = name
        phoneLabel.text = phone
        birthdayLabel.text = birthday
        genderLabel.text = genders[Int(gender) ?? 2]
        locationLabel.text = "\(city),  \(state)"
        
        }
    
    func setupMap(){
        let firstName = name.components(separatedBy: " ")[0]
        
        let span : MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let location : CLLocationCoordinate2D = CLLocationCoordinate2DMake(Double(latitude)!, Double(longitude)!)
        let region : MKCoordinateRegion = MKCoordinateRegion(center: location,span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = location
        annotation.title = "\(firstName)'s home"
        annotation.subtitle = "\(city),\(state)"
        mapView.addAnnotation(annotation)
    }
}
