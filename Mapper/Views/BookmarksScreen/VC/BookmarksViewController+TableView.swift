//
//  BookmarksViewController+TableView.swift
//  Mapper
//
//  Created by Brett on 11/20/19.
//  Copyright © 2019 Brett. All rights reserved.
//

import Foundation
import UIKit

// MARK: - UITableViewDataSource
extension BookmarksViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarksNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BookmarkTableViewCell
        cell.nameLabel.text = bookmarksNames[indexPath.row]
        cell.streetLabel.text = bookmarksStreets[indexPath.row]
        cell.loc = bookmarksLocs[indexPath.row]
        cell.index = indexPath.row
        cell.bVC = self
        cell.mVC = mapVC
        cell.info = bookmarksInfo[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
    
    
}
