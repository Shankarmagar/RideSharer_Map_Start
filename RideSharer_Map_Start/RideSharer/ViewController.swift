//
//  ViewController.swift
//  RideSharer
//
//  Created by Shankar Ale Magar on 12/29/22.
//

import UIKit
import MapKit
class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            checkLocationServices()
        }
        
        func checkLocationServices() {
            if CLLocationManager.locationServicesEnabled() {
                checkAuthorizationStatus()
            }
        }
        
        func checkAuthorizationStatus() {
            switch locationManager.authorizationStatus {
            case .authorizedWhenInUse:
                mapView.showsUserLocation = true
            case .denied:
                showAlert()
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
                mapView.showsUserLocation = true
            case .restricted:
                break
            case .authorizedAlways:
                break
            @unknown default:
                break
            }
        }
        
        func showAlert() {
            let alertController = UIAlertController(title: "Denied", message: "You have not given permission to get your location. Please change this in system settings.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }


