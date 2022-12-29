//
//  ViewController.swift
//  MapKitTutorial
//
//  Created by Duy Bui on 4/4/19.
//  Copyright © 2019 DuyBui. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate{

  let locationManager = CLLocationManager()
  
    @IBOutlet weak var Mapping: MKMapView!
    override func viewDidLoad() {
    super.viewDidLoad()
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      
      if(CLLocationManager.locationServicesEnabled())
      {
          locationManager.requestLocation()
          locationManager.startUpdatingLocation()
      }
  }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.first
        {
            manager.stopUpdatingLocation()
            
            let coordinates = CLLocationCoordinate2D(latitude: locationManager.location?.coordinate.latitude ?? 0.0, longitude: locationManager.location?.coordinate.longitude ?? 0.0)
            let span = MKCoordinateSpan (latitudeDelta: 0.1, longitudeDelta: 0.1)
            
            let region = MKCoordinateRegion(center: coordinates, span: span)
            
            Mapping.setRegion(region, animated: true)
            
            let MyPin = MKPointAnnotation()
            MyPin.coordinate = coordinates
        }
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways:
            return
        case .authorizedWhenInUse:
            return
        case .denied:
            return
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return
        case .restricted:
            locationManager.requestWhenInUseAuthorization()
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print (error)
    }
  }
