//
//  BookmarksViewController.swift
//  Mapper
//
//  Created by Brett on 11/4/19.
//  Copyright © 2019 Brett. All rights reserved.
//

import UIKit
import MapKit

class BookmarksViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!{
        didSet{
            tableView.dataSource = self
            let nib = UINib(nibName: "BookmarkTableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "cell")
            tableView.rowHeight = 75
        }
    }
    
    var bookmarksNames: [String] = []
    var bookmarksStreets: [String] = []
    var bookmarksLocs: [CLLocation] = []
    var bookmarksInfo: [GeocodingInfo] = []
    var mapVC: MapViewController?
    var tabBarC: TabBarController?
    let service = FileService()
    
    // Block to delete item, filled out in tableView cell
    var delBlock: ((UIAlertAction) -> Void)?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
    }
    
    // switches to map tab
    func switchMap(){
        tabBarC?.selectedIndex = 0
    }
    
    func removeLocation(at index: Int){
        bookmarksNames.remove(at: index)
        bookmarksStreets.remove(at: index)
        bookmarksLocs.remove(at: index)
        bookmarksInfo.remove(at: index)
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
        save()
    }
    
    func showAlert(text: String) {
        let alert = UIAlertController(title: text, message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Delete", style: .destructive, handler: delBlock)
        alert.addAction(ok)
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}
