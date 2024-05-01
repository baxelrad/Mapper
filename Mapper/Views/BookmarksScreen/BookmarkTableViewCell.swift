//
//  BookmarkTableViewCell.swift
//  Mapper
//
//  Created by Brett on 11/20/19.
//  Copyright © 2019 Brett. All rights reserved.
//

import UIKit
import CoreLocation

class BookmarkTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var streetLabel: UILabel!
    
    var bVC: BookmarksViewController?
    var mVC: MapViewController?
    var loc: CLLocation?
    var info: GeocodingInfo?
    
    var index: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        bVC?.delBlock = { _ in
            self.bVC?.removeLocation(at: self.index!)
        }
        bVC?.showAlert(text: "Delete \(String(describing: nameLabel.text!))?")
    }
    
    @IBAction func jumpAction(_ sender: Any) {
        bVC?.switchMap()
        mVC?.jumpTo(loc!)
        mVC?.placeAnnotation(on: loc!, info: info!)
        mVC?.searchBar.text = nameLabel.text
        mVC?.nameStore = nameLabel.text
        
    }
    
    
}
