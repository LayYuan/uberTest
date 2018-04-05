//
//  RiderViewController.swift
//  uberTest
//
//  Created by LayYuan on 04/04/2018.
//  Copyright © 2018 justCodeEnterprise. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase
import FirebaseAuth
                                             //4
class RiderViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var callAnUber: UIButton!
    
    //1
    var locationManager = CLLocationManager()
    
    var userLocation = CLLocationCoordinate2D()
    var uberHasBeenCalled = false
    
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
            userLocation = center
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
        
        //get email
        if let email = Auth.auth().currentUser?.email{
            
            if uberHasBeenCalled {
                
                uberHasBeenCalled = false
                callAnUber.setTitle("Call An Uber", for: .normal)
                
                //Retrieve from database
                Database.database().reference().child("RideRequests").queryOrdered(byChild: "email").queryEqual(toValue: email).observe(.childAdded, with: { (snapshot) in
                    //to Remove the thing we search for
                    snapshot.ref.removeValue()
                    
                    //Remove all observer
                    Database.database().reference().child("RideRequests").removeAllObservers()
                })
                
            }else {
                //write to database
                let rideRequestDictionary: [String:Any] = ["email": email, "lat": userLocation.latitude, "lon": userLocation.longitude]
                Database.database().reference().child("RideRequests").childByAutoId().setValue(rideRequestDictionary)
                
                uberHasBeenCalled = true
                callAnUber.setTitle("Cancel Uber", for: .normal)
            }
            
        
        }
    }
    
    
    
}
