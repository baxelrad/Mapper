//
//  MapViewController + mapView.swift
//  Mapper
//
//  Created by Brett on 11/15/19.
//  Copyright © 2019 Brett. All rights reserved.
//

import Foundation
import UIKit
import MapKit


// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate{
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let pin = pinAnnotation(annotation)
        //pin?.canShowCallout = true
        //pin?.detailCalloutAccessoryView = aCallout(annotation)
        return pin
    }

    
    func pinAnnotation(_ annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation.isKind(of: MKUserLocation.self){
            return nil
        }
        let pin = mapView.dequeueReusableAnnotationView(withIdentifier: "pinReuseID", for: annotation) as! MKPinAnnotationView
        pin.pinTintColor = MKPinAnnotationView.greenPinColor()
        return pin
    }
    
    func mapView(_ mapView: MKMapView,
                 didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        if annotation.isKind(of: MKUserLocation.self) {
            return
        }
        if let anno = view.annotation as? CustomAnnotation,
            var info = anno.info{
            info.street = info.name
            info.name = nameStore
            callout.nameLabel.text = info.name
            callout.streetLabel.text = info.street
            callout.location = anno.location
            if info.street != nil{
                callout.fullAddress = "\(String(describing: info.street!)), \(String(describing: info.city!)), \(String(describing: info.zipcode!))"
            }
            else{
                callout.fullAddress = "\(String(describing: info.city!)), \(String(describing: info.zipcode!))"
            }
            callout.info = info
            
            callout.place(in: self, for: anno.coordinate, mapView: mapView)
        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        if annotation.isKind(of: MKUserLocation.self){
            return
        }
        if (view.annotation as? CustomAnnotation) != nil {
            callout.remove()
        }
    }
}

extension MapViewController: CustomAnnotationCalloutDelegate {
    func saveAction(name: String, street: String, loc: CLLocation, info: GeocodingInfo) {
        //print("did move to VC")
        if bookmarksVC?.bookmarksStreets != nil{
            for item in bookmarksVC!.bookmarksStreets{
                if (item == street){
                    showAlert(text: "Already saved")
                    return
                }
            }
        }
        bookmarksVC?.bookmarksNames.append(name)
        bookmarksVC?.bookmarksStreets.append(street)
        bookmarksVC?.bookmarksLocs.append(loc)
        bookmarksVC?.bookmarksInfo.append(info)
        DispatchQueue.main.async {
            self.bookmarksVC?.tableView.reloadData()
        }
        bookmarksVC?.save()
    }
    func didPlace() {
        //print("did place on map")
        
    }
    func didHide() {
        //print("did remove from map")
    }
    
}

