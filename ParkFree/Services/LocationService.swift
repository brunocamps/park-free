//
//  LocationService.swift
//  ParkFree
//
//  Created by Bruno Campos on 1/25/18.
//  Copyright © 2018 Bruno Campos. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    
    static let instance = LocationService() //static: it will "live" across the entire run of the app.
    
    var locationManager = CLLocationManager()
    
    var currentLocation: CLLocationCoordinate2D?
    
    override init(){ //overriding default attributes
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter = 50
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
        
        self.currentLocation = locationManager.location?.coordinate
        
    }

}
