//
//  ViewController.swift
//  ParkFree
//
//  Created by Bruno Campos on 1/25/18.
//  Copyright © 2018 Bruno Campos. All rights reserved.
//Ver. 1.0

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var roundButton: RoundButton!
    
    @IBOutlet weak var mapVIew: MKMapView!
    
    let regionRadius: CLLocationDistance = 500
    
    var parkedCarAnnotation: ParkingSpot?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapVIew.delegate = self
        checkLocationAuthorizationStatus()
    }
    
    @IBAction func parkBtnWasPressed(_ sender: Any) {
        
        if mapVIew.annotations.count == 1 {
            mapVIew.addAnnotation(parkedCarAnnotation!)
            roundButton.setImage(UIImage(named: "foundCar.png"), for: .normal)
        } else {
            mapVIew.removeAnnotations(mapVIew.annotations)
            roundButton.setImage(UIImage(named: "parkCar.png"), for: .normal)
        }
        centerMapOnLocation(location: LocationService.instance.locationManager.location!)

    }
    
    func checkLocationAuthorizationStatus(){
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapVIew.showsUserLocation = true
            LocationService.instance.locationManager.delegate = self
            LocationService.instance.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            LocationService.instance.locationManager.startUpdatingLocation()
            
        } else {
            LocationService.instance.locationManager.requestWhenInUseAuthorization()
        }
        
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapVIew.setRegion(coordinateRegion, animated: true)
    }
    

}

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? ParkingSpot { //create an annotation only if it is of type ParkingSpot
            let identifier = "pin" //identifier (pin)
            var view: MKPinAnnotationView //create view variable of type MKPinAnnotationView
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.animatesDrop = true
            view.pinTintColor = UIColor.orange
            view.calloutOffset = CGPoint(x: -8, y: -3)
            view.rightCalloutAccessoryView = UIButton.init(type: .detailDisclosure) as UIView //when we tap the pin, on the white pop-up we want there to be a Detail Disclosure btn on the right-hand side
            return view //view is of type MKAnnotationView
    
        } else {
            return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl)
    {
        let location = view.annotation as! ParkingSpot //constant location which we set with view.annotation and downcast with the type ParkingSpot
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        location.mapItem(location: (parkedCarAnnotation?.coordinate)!).openInMaps(launchOptions: launchOptions)
    } //this function handles what happens when we tap on the Detail Disclosure btn on the white pop-up view after tapping on the pin we drop.
    
}

extension ViewController: CLLocationManagerDelegate {
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        centerMapOnLocation(location: CLLocation(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude))
        
        let locationServiceCoordinate = LocationService.instance.locationManager.location!.coordinate
        
        parkedCarAnnotation = ParkingSpot(title:"My Parking Spot", locationName: "Tap the 'i' for GPS", coordinate: CLLocationCoordinate2D(latitude: locationServiceCoordinate.latitude, longitude: locationServiceCoordinate.longitude))
        
    }
    
    
}


    
    
    
    
    


