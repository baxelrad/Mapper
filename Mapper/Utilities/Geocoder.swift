//
//  Geocoder.swift
//  Mapper
//
//  Created by Brett on 11/14/19.
//  Copyright © 2019 Brett. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class Geocoder{
    
    var mapItems: [MKMapItem] = []
    init(){
        
    }
    
    func find(_ query: String, region: MKCoordinateRegion, completion: @escaping ()->Void){
        let r = MKLocalSearch.Request()
        r.naturalLanguageQuery = query
        r.region = region

        let search = MKLocalSearch(request: r)
        search.start{ (response, err) in
            self.mapItems = []

            if let err = err {print(err); return}
            guard let r = response else {return}
            for item in r.mapItems{
                self.mapItems.append(item)
            }
            completion()
        }
    }
}
