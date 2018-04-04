//
//  RiderViewController.swift
//  uberTest
//
//  Created by LayYuan on 04/04/2018.
//  Copyright © 2018 justCodeEnterprise. All rights reserved.
//

import UIKit
import MapKit
                                             //4
class RiderViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var callAnUber: UIButton!
    
    //1
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //2
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //3. Add privacy at plist
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    //5
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coord = manager.location?.coordinate{
            let center = CLLocationCoordinate2D(latitude: coord.latitude, longitude: coord.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            //update Map
            map.setRegion(region, animated: true)
            
            map.removeAnnotations(map.annotations)
            
            //6 Set pin
            let annotation = MKPointAnnotation()
            annotation.coordinate = center
            annotation.title = "Your Location"
            map.addAnnotation(annotation)
            
        }
    }

    @IBAction func logoutTapped(_ sender: Any) {
    }
    
    @IBAction func callAnUberTapped(_ sender: Any) {
    }
    
}
