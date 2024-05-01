//
//  MapViewController + tableView.swift
//  Mapper
//
//  Created by Brett on 11/15/19.
//  Copyright © 2019 Brett. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UITableViewDataSource
extension MapViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loc.mapItems.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultsTableViewCell
        cell.nameLabel.text = loc.mapItems[indexPath.row].name
        cell.addressLabel.text = loc.mapItems[indexPath.row].placemark.title
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension MapViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.isHidden = true
        let item = loc.mapItems[indexPath.row]
        let location = item.placemark.location
        jumpTo(location!)
        self.manager.geocode(location!, { (info) in
            self.placeAnnotation(on: location!, info: info)
        })
        
        nameStore = loc.mapItems[indexPath.row].name
        searchBar.text = nameStore
    }
}
