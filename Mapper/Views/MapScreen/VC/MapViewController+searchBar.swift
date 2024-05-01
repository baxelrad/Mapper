//
//  MapViewController + searchBar.swift
//  Mapper
//
//  Created by Brett on 11/15/19.
//  Copyright © 2019 Brett. All rights reserved.
//

import Foundation
import UIKit
import MapKit

// MARK: - UISearchBarDelegate
extension MapViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        tableView.isHidden = false
        
        if (searchBar.text?.isEmpty ?? true) {
            tableView.isHidden = true
        }
        
        // Wait .35 seconds after user is done typing before performing search
        if dispatchThrottle?.workItem != nil{
            dispatchThrottle?.cancel()
        }        
        dispatchThrottle = DispatchThrottle(queue: .main, { [weak self] in
            let c = self!.mapView.userLocation.coordinate
            
            let r = MKCoordinateRegion(center: c, span: self!.mapView.region.span)
            self!.loc.find(searchText, region: r) { [weak self] in
                guard let self = self else { return }
                // Adjust size of tableView to amount of elements (with a limit)

                let height: CGFloat
                if (self.loc.mapItems.count >= 4){
                    height = 175
                }
                else {
                    height = CGFloat((175 / 4.0) * Float(self.loc.mapItems.count))
                }
                self.tableView.frame.size.height = height
                // self.tableView.frame = frame
                self.tableView.reloadData()
            }
        })
    }
}

