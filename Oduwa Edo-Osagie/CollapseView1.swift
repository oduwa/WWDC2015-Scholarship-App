//
//  CollapseView1.swift
//  Oduwa Edo-Osagie
//
//  Created by Odie Edo-Osagie on 19/04/2015.
//  Copyright (c) 2015 Odie Edo-Osagie. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class CollapseView1: UIView, MKMapViewDelegate {

    
    @IBOutlet  var textLabel: UILabel!
    @IBOutlet  var mapView: MKMapView!
    
    var isViewShowing : Bool!;
    
    class func instanceFromNib() -> UIView {
        //return UINib(nibName: "CenterHomeView", bundle: NSBundle.mainBundle()).instantiateWithOwner(self, options: nil)[0] as! UIView
        return NSBundle.mainBundle().loadNibNamed("CollapseView1", owner: self, options: nil)[0] as! UIView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(){
        mapView.delegate = self;
        
        var lat = 51.776586100123//6.4531
        var long = -0.23506209690483//3.3500201;
        
        let center = CLLocationCoordinate2D(latitude: lat, longitude: long);
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05));
        self.mapView.region = region;
        
        var dropPin = MKPointAnnotation();
        dropPin.coordinate = center;
        dropPin.title = "Where I live!🏠😊";
        mapView.addAnnotation(dropPin);
        mapView.selectAnnotation(dropPin, animated: true);
        
        /* Text Label */
        textLabel.text = "Originally from Nigeria, I am a third year student at the University of East Anglia studying Software Engineering."

    }
    
    

}
