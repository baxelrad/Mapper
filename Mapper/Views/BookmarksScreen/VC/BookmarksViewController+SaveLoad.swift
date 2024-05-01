//
//  BookmarksViewController+SaveLoad.swift
//  Mapper
//
//  Created by Brett on 11/20/19.
//  Copyright © 2019 Brett. All rights reserved.
//

import Foundation
import CoreLocation

extension BookmarksViewController{
    
    // MARK: - Save/Load
    func save(){
        service.saveNames(array: bookmarksNames)
        service.saveStreets(array: bookmarksStreets)
        var lats: [Double] = []
        var lons: [Double] = []
        for item in bookmarksLocs{
            lats.append(item.coordinate.latitude)
            lons.append(item.coordinate.longitude)
        }
        service.saveLats(array: lats)
        service.saveLons(array: lons)
        var names: [String] = []
        var streets: [String] = []
        var cities: [String] = []
        var zips: [String] = []
        
        for item in bookmarksInfo{
            names.append(item.name ?? "")
            streets.append(item.street ?? "")
            cities.append(item.city ?? "")
            zips.append(item.zipcode ?? "")
        }
        
        service.saveInfoName(array: names)
        service.saveInfoStreet(array: streets)
        service.saveInfoCity(array: cities)
        service.saveInfoZip(array: zips)
    }
    
    func load(){
        bookmarksNames = service.loadArrayNames()
        bookmarksStreets = service.loadArrayStreets()
        let lats = service.loadArrayLats()
        let lons = service.loadArrayLons()
        if (lats.count != lons.count){
            print ("Load Error!")
            return
        }
        for i in 0 ..< lats.count {
            bookmarksLocs.append(CLLocation(latitude: lats[i], longitude: lons[i]))
        }
        let names = service.loadArrayNames()
        let streets = service.loadArrayInfoStreet()
        let cities = service.loadArrayInfoCity()
        let zips = service.loadArrayInfoZip()
        if (names.count != streets.count){
            print ("Load Error!")
            return
        }
        for i in 0 ..< names.count{
            bookmarksInfo.append((name: streets[i], street: streets[i], city: cities[i], zipcode: zips[i]))
        }
    }
}
