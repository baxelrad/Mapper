//
//  TabBarController.swift
//  Mapper
//
//  Created by Brett on 11/20/19.
//  Copyright © 2019 Brett. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    var firstVC: MapViewController!
    var secondVC: BookmarksViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
        firstVC = viewControllers![0] as? MapViewController
        secondVC = viewControllers![1] as? BookmarksViewController
        firstVC.bookmarksVC = secondVC
        secondVC.mapVC = firstVC
        secondVC.tabBarC = self

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
