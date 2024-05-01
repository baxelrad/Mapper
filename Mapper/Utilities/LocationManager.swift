//
//  LocationManager.swift
//  Mapper
//
//  Created by Brett on 11/13/19.
//  Copyright © 2019 Brett. All rights reserved.
//

import Foundation
import CoreLocation

typealias GeocodingInfo = (name: String?, street: String?, city: String?, zipcode: String?)

class LocationManager: NSObject{
    let manager = CLLocationManager()
    
    var updateLoc: ((CLLocation) -> Void)?
    var lastLocation: CLLocation?
    let geocoder = CLGeocoder()
    
    override init(){
        super.init()
        manager.delegate = self
    }
    
    func getCurrentLocation(_ completion: @escaping (CLLocation) -> Void){
        manager.requestWhenInUseAuthorization()
        if let loc = lastLocation{
            completion(loc)
        }
        else{
            updateLoc = { (loc) in
                completion(loc)
                self.updateLoc = nil
            }
        }
    }
    
    // gets permission to see location
    func permissionToTrack(_ completion: @escaping (CLLocation) -> Void){
        manager.requestWhenInUseAuthorization()
        
        updateLoc = completion
    }
    
    func startTrackingLocation(){
        manager.startUpdatingLocation()
    }
    
    func geocode(_ location: CLLocation, _ completion: @escaping (GeocodingInfo) -> Void){
        if geocoder.isGeocoding{
            geocoder.cancelGeocode()
        }
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let err = error{
                print(err)
            }
            
            if let p = placemarks?.first {
                let info = (name: p.name,
                            street: p.thoroughfare,
                            city: p.locality,
                            zipcode: p.postalCode)
                completion(info)
            }
        }
    }
}


// MARK: - CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status{
        case .authorizedAlways:
            fallthrough
        case .authorizedWhenInUse:
            startTrackingLocation()
        default:
            print("authorization cancelled")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.first
            else{
                return
        }
        
        lastLocation = loc
        
        updateLoc?(loc)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
