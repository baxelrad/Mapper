//
//  CustomAnnotationCallout.swift
//  Mapper
//
//  Created by Brett on 11/14/19.
//  Copyright © 2019 Brett. All rights reserved.
//

import UIKit
import MapKit

protocol CustomAnnotationCalloutDelegate {
    func didPlace()
    func didHide()
    func saveAction(name: String, street: String, loc: CLLocation, info: GeocodingInfo)
}


class CustomAnnotationCallout: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var streetLabel: UILabel!
    @IBOutlet var saveButton: UIButton!
    var delegate: CustomAnnotationCalloutDelegate?
    var location: CLLocation?
    var fullAddress: String?
    var info: GeocodingInfo?
    
    init(){
        super.init(frame: .zero)
        let bundle = Bundle(for: CustomAnnotationCallout.self)
        bundle.loadNibNamed("CustomAnnotationCallout", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        saveButton.addTarget(self, action: #selector(saveAction(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func saveAction(_ sender: Any) {
        delegate?.saveAction(name: nameLabel.text!, street: fullAddress!, loc: location!, info: info!)
        //print("check")
    }
}

extension CustomAnnotationCallout {
    
    func place(in vc: UIViewController,
               for coord: CLLocationCoordinate2D,
               mapView: MKMapView) {
        // if already on the superview, remove it.
        // harmless to call if it's not.
        self.removeFromSuperview()
        
        // calculate new position for placing the annotation
        // wrt where the pin is located on the map
        var aFrame = self.frame
        var point = mapView.convert(coord,
                                    toPointTo: vc.view)
        point.x = point.x - (self.frame.width / 2.0)
        point.y = point.y - (self.frame.height) - 25.0 // or whatever offset you'd like
        aFrame.origin = point
        self.frame = aFrame
        
        // place it on the rootViewController, instead
        vc.view.addSubview(self)
        self.delegate?.didPlace()
    }
    
    func remove(_ animated: Bool = true) {
        // embedded function to be performed when removal is completed
        func completion() {
            self.removeFromSuperview()
            self.alpha = 1.0
            self.delegate?.didHide()
        }
        if animated == false {
            completion()
            return
        }
        UIView.animate(withDuration: 0.35, animations: {
            self.alpha = 0.0
        }) { (finished) in
            if finished {
                completion()
            }
        }
    }
}
