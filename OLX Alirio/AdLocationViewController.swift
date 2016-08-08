//
//  AdLocationViewController.swift
//  OLX Alirio
//
//  Created by Alírio Mendes on 03/06/16.
//  Copyright © 2016 Alírio Mendes. All rights reserved.
//

import UIKit
import GoogleMaps
class AdLocationViewController: UIViewController {

    var ad:Ad!
    
    override func viewDidLoad() {
        self.navigationController!.navigationBar.topItem!.title = ""
        
        let location = CLLocationCoordinate2DMake(self.ad.map_lat!, self.ad.map_lon!)
        let zoom = self.ad.map_zoom != nil ? self.ad.map_zoom! : 12
        let camera = GMSCameraPosition.camera(withTarget: location, zoom: Float(zoom))
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        let marker = GMSMarker(position: location)
        marker.title = ad.city_label
        marker.map = mapView
        
        let circ = GMSCircle(position: location, radius: self.ad.map_radius!*1000)
        circ.fillColor = UIColor(red: 0.7, green: 0.1, blue: 0.2, alpha: 0.1)
        circ.strokeColor = UIColor(red: 0.9, green: 0.1, blue: 0.5, alpha: 0.2)
        circ.strokeWidth = 1.0;
        circ.map = mapView
        
        
        view = mapView
    }
    override func viewDidAppear(_ animated: Bool) {
    
    }
    
    
}
