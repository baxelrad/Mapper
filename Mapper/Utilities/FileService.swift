//
//  FileService.swift
//  Mapper
//
//  Created by Brett on 11/20/19.
//  Copyright © 2019 Brett. All rights reserved.
//

import Foundation
import CoreLocation

class FileService{
    
    let fileManager: FileManager
    let directory: URL
    private let fileNames = "MapperNames"
    private let fileStreets = "MapperStreets"
    private let fileLats = "MapperLats"
    private let fileLons = "MapperLons"
    private let fileInfoName = "MapperInfoName"
    private let fileInfoStreet = "MapperInfoStreet"
    private let fileInfoCity = "MapperInfoCity"
    private let fileInfoZipCode = "MapperInfoZipCode"



    init(){
        fileManager = FileManager.default
        directory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first!
    }
    
    func save(name: String, _ dat: Data) {
        do {
            let file = directory.appendingPathComponent(name)
            try dat.write(to: file)
        }
        catch{
            //print ("save-stop")
        }
    }
    
    func load(name: String) -> Data?{
        do{
            let file = directory.appendingPathComponent(name)
            let dat: Data = try Data(contentsOf: file)
            return dat
        }
        catch{
            //print("load-stop")
        }
        return nil
    }
    
    
    
    
    
    //MARK: - Saving/loading names
    func saveNames(array: [String]) {
        // array -> Data
        do {
            let arrayData = try JSONSerialization.data(withJSONObject: array,
                                                       options: .prettyPrinted)
            save(name: fileNames, arrayData)
        }
        catch { }
    }
    
    func loadArrayNames() -> [String] {
        guard let data = load(name: fileNames) else { return [] }
        // data -> array
        do {
            let arr = try JSONSerialization.jsonObject(with: data,
                                                       options: .mutableLeaves) as! [String]
            return arr
        }
        catch { }
        return []
    }
    
    
    // MARK: - Saving/loading Streets
    func saveStreets(array: [String]) {
        // array -> Data
        do {
            let arrayData = try JSONSerialization.data(withJSONObject: array,
                                                       options: .prettyPrinted)
            save(name: fileStreets, arrayData)
        }
        catch { }
    }
    
    
    func loadArrayStreets() -> [String] {
        guard let data = load(name: fileStreets) else { return [] }
        // data -> array
        do {
            let arr = try JSONSerialization.jsonObject(with: data,
                                                       options: .mutableLeaves) as! [String]
            return arr
        }
        catch { }
        return []
    }
    
    
    // MARK: - Saving/loading Locations
    func saveLats(array: [Double]) {
        // array -> Data
        do {
            let arrayData = try JSONSerialization.data(withJSONObject: array,
                                                       options: .prettyPrinted)
            save(name: fileLats, arrayData)
        }
        catch { }
    }
    
    func loadArrayLats() -> [Double] {
        guard let data = load(name: fileLats) else { return [] }
        // data -> array
        do {
            let arr = try JSONSerialization.jsonObject(with: data,
                                                       options: .mutableLeaves) as! [Double]
            return arr
        }
        catch { }
        return []
    }
    
    func saveLons(array: [Double]) {
        // array -> Data
        do {
            let arrayData = try JSONSerialization.data(withJSONObject: array,
                                                       options: .prettyPrinted)
            save(name: fileLons, arrayData)
        }
        catch { }
    }
    
    func loadArrayLons() -> [Double] {
        guard let data = load(name: fileLons) else { return [] }
        // data -> array
        do {
            let arr = try JSONSerialization.jsonObject(with: data,
                                                       options: .mutableLeaves) as! [Double]
            return arr
        }
        catch { }
        return []
    }
    
    
    //MARK: - Saving/loading GeocodingInfo
    func saveInfoName(array: [String]) {
        // array -> Data
        do {
            let arrayData = try JSONSerialization.data(withJSONObject: array,
                                                       options: .prettyPrinted)
            save(name: fileInfoName, arrayData)
        }
        catch { }
    }
    
    func loadArrayInfoName() -> [String] {
        guard let data = load(name: fileInfoName) else { return [] }
        // data -> array
        do {
            let arr = try JSONSerialization.jsonObject(with: data,
                                                       options: .mutableLeaves) as! [String]
            return arr
        }
        catch { }
        return []
    }
    
    func saveInfoStreet(array: [String]) {
        // array -> Data
        do {
            let arrayData = try JSONSerialization.data(withJSONObject: array,
                                                       options: .prettyPrinted)
            save(name: fileInfoStreet, arrayData)
        }
        catch { }
    }
    
    func loadArrayInfoStreet() -> [String] {
        guard let data = load(name: fileInfoStreet) else { return [] }
        // data -> array
        do {
            let arr = try JSONSerialization.jsonObject(with: data,
                                                       options: .mutableLeaves) as! [String]
            return arr
        }
        catch { }
        return []
    }
    
    func saveInfoCity(array: [String]) {
        // array -> Data
        do {
            let arrayData = try JSONSerialization.data(withJSONObject: array,
                                                       options: .prettyPrinted)
            save(name: fileInfoCity, arrayData)
        }
        catch { }
    }
    
    func loadArrayInfoCity() -> [String] {
        guard let data = load(name: fileInfoCity) else { return [] }
        // data -> array
        do {
            let arr = try JSONSerialization.jsonObject(with: data,
                                                       options: .mutableLeaves) as! [String]
            return arr
        }
        catch { }
        return []
    }
    
    func saveInfoZip(array: [String]) {
        // array -> Data
        do {
            let arrayData = try JSONSerialization.data(withJSONObject: array,
                                                       options: .prettyPrinted)
            save(name: fileInfoZipCode, arrayData)
        }
        catch { }
    }
    
    func loadArrayInfoZip() -> [String] {
        guard let data = load(name: fileInfoZipCode) else { return [] }
        // data -> array
        do {
            let arr = try JSONSerialization.jsonObject(with: data,
                                                       options: .mutableLeaves) as! [String]
            return arr
        }
        catch { }
        return []
    }
    
}
