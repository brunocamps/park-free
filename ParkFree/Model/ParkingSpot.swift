//
//  ParkingSpot.swift
//  ParkFree
//
//  Created by Bruno Campos on 1/25/18.
//  Copyright © 2018 Bruno Campos. All rights reserved.
//

import UIKit
import MapKit
import Contacts

class ParkingSpot: NSObject, MKAnnotation { //After : are the inherited classes
    
    //Create three properties for the title, location name and coordinate of the Map View annotation.
    
    let title: String? //optional
    let locationName: String? //optional
    let coordinate: CLLocationCoordinate2D //required
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
    }
    
    var subtitle: String? {
        return locationName
    }
    
    func mapItem(location: CLLocationCoordinate2D) -> MKMapItem {
        let addressDictionary = [String(CNPostalAddressStreetKey): subtitle]
        let placemark = MKPlacemark(coordinate: location, addressDictionary: addressDictionary)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
    

}


