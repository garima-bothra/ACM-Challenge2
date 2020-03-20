//
//  mapViewController.swift
//  ACM-Challenge2
//
//  Created by Aaryan Kothari on 20/03/20.
//  Copyright © 2020 Garima Bothra. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

var latlong = [0.0,0.0]

class mapViewController: UIViewController{
    
    //MARK:- Outlets
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    //MARK:- Variables & Constants
    let locationManager = CLLocationManager()
    var previousLocation : CLLocation?
    
    
    //MARK: - initial setup
    override func viewDidLoad() {
        super.viewDidLoad()
        addressLabel.text = "move pin..."
        checkLocationServicesEnables()
    }
    
    
    //MARK: - Location Methods
    
    //setup location manager
    func setupLocationManager(){
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
        
    
    //verify location status
    func checkLocationServicesEnables(){
      if CLLocationManager.locationServicesEnabled() {
          setupLocationManager()
          checkLocationAuthorization()
        } else {
            createAlert(message: "Please Turn on Locations from settings")
            }
        }
          
    
      //check location authorization
      func checkLocationAuthorization(){
          switch CLLocationManager.authorizationStatus() {
          case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centreViewOnUsersLocation()
            locationManager.startUpdatingLocation()
            previousLocation = getCentreLocation(for: mapView)
            break
          case .denied:
            print("location access denied")
            break
          case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
          case .restricted:
            print("location access restricted")
            break
          case .authorizedAlways:
            print("location access authorized")
            break
          @unknown default:
              fatalError()
          }
      }
          
    
      //set centre to current location
      func centreViewOnUsersLocation(){
      if let location = locationManager.location?.coordinate {
          let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 10000, longitudinalMeters: 1000)
          mapView.setRegion(region, animated: true)
          }
      }

    //Get centre coordinates
    func getCentreLocation(for mapView : MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
      
      
      //Create alert function
      func createAlert(message: String){
          let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
          let action = UIAlertAction(title: "ok", style: .default, handler: nil)
          alert.addAction(action)
      }
}


extension mapViewController : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {  checkLocationAuthorization()  }
}



extension mapViewController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let centre = getCentreLocation(for: mapView)
        let geoCoder = CLGeocoder()
        
        guard let _ = self.previousLocation else { return }
        guard centre.distance(from: self.previousLocation!) > 50 else { return }
        self.previousLocation = centre
        
        geoCoder.reverseGeocodeLocation(centre) { [weak self] (placemarks,error) in
            guard let self = self else { return }
            if let _ = error {
                self.createAlert(message: "ERROR")
            }
            guard let placemark = placemarks?.first else { return }
            let streetNumber = placemark.subThoroughfare ?? ""
            let streetName = placemark.thoroughfare ?? ""
            
            DispatchQueue.main.async {
                self.addressLabel.text = "\(streetNumber) \(streetName)"
                //print(self.getCentreLocation(for: mapView).coordinate.latitude)
                latlong[0] = self.getCentreLocation(for: mapView).coordinate.latitude
                latlong[1] = self.getCentreLocation(for: mapView).coordinate.longitude
            }
        }
    }
}
