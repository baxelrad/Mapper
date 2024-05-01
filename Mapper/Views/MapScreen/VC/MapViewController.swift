//
//  ViewController.swift
//  Mapper
//
//  Created by Brett on 11/4/19.
//  Copyright © 2019 Brett. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet var currentLocationButton: UIButton! {
        didSet {
            let layer = currentLocationButton.layer
            layer.cornerRadius = 35.0
            layer.masksToBounds = true
            let gColor = currentLocationButton.titleLabel?.textColor
            layer.borderColor = gColor?.cgColor
            layer.borderWidth = 2.0
        }
    }
    
    @IBOutlet var searchBar: UISearchBar!{
        didSet{
            searchBar.delegate = self
        }
    }
    
    @IBOutlet var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
            mapView.register(MKAnnotationView.self,
                             forAnnotationViewWithReuseIdentifier: "reuseID")
            mapView.register(MKPinAnnotationView.self,
                             forAnnotationViewWithReuseIdentifier: "pinReuseID")
            
        }
    }
    // Shows search results, disappears when result is selected or when search bar is empty.
    @IBOutlet var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            tableView.delegate = self
            let nib = UINib(nibName: "ResultsTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "cell")
        }
    }
    
    lazy var callout: CustomAnnotationCallout = {
        let c = CustomAnnotationCallout()
        c.frame = CGRect(x: 0, y: 0, width: 200, height: 60)
        c.delegate = self
        return c
    }()
    
    
    let manager = LocationManager()
    var currAnnotation: MKPointAnnotation!
    let loc = Geocoder()
    var dispatchThrottle: DispatchThrottle?
    var bookmarksVC: BookmarksViewController?
    var nameStore: String?

    
    @IBAction func currentLocationAction(_ sender: Any) {
        manager.getCurrentLocation { loc in
            self.jumpTo(loc)
            
            /*self.manager.geocode(loc, { (info) in
                self.placeAnnotation(on: loc, info: info)
            })*/
        }
    }
    // Divide miles by 69 for latitude, divide by 60 for longitude
    /// Jumps to a given CLLocation
    func jumpTo(_ loc: CLLocation){
        let latDelta: CLLocationDegrees = 5.0 / 69.0  //5 miles
        let lonDelta: CLLocationDegrees = 5.0 / 60.0  //5 miles
        let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let region = MKCoordinateRegion(center: loc.coordinate, span: span)
        callout.remove()
        /*let name: String? = "Mount Rushmore the biggest peaks of all of America"
        let street: String? = "America"
        let city: String? = "Kansas"
        let zipcode: String? = "9999999"
        let info = (name: name, street: street, city: city, zipcode: zipcode)
        placeAnnotation(on: loc, info: info)*/
        mapView.setRegion(region, animated: true)
    }
    
    
    /// Places an annotation on a given CLLocation, containing info on that location (GeocodingInfo)
    func placeAnnotation(on loc: CLLocation, info: GeocodingInfo){
        if let curr = currAnnotation{
            mapView.removeAnnotation(curr)
        }
        let curr = CustomAnnotation()
        curr.location = loc
        curr.title = info.name
        curr.subtitle = info.street
        curr.info = info
        curr.coordinate = loc.coordinate
        currAnnotation = curr
        mapView.addAnnotation(currAnnotation)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentLocationAction(self)
        self.mapView.showsUserLocation = true
        
        // Preload ViewControllers
        for viewController in tabBarController?.viewControllers ?? [] {
            if let navigationVC = viewController as? UINavigationController, let rootVC = navigationVC.viewControllers.first {
                let _ = rootVC.view
            } else {
                let _ = viewController.view
            }
        }
    }
    
    func showAlert(text: String) {
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
