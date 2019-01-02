//
//  NotificationViewController.swift
//  notificationCamionContent
//
//  Created by Forest Cab on 13/04/2018.
//  Copyright © 2018 Administrateur. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
//import GoogleMaps
import MapKit
import CallKit







    typealias MapViewRendered = NotificationViewController


    class NotificationViewController: UIViewController, UNNotificationContentExtension {
         var newLocation = CLLocationCoordinate2D()
       
       // @IBOutlet weak var mapView: MKMapView!
         @IBOutlet weak var mapView: MKMapView!
        @IBOutlet var label: UILabel?
        
      
        override func viewDidLoad() {
            super.viewDidLoad()
           
            mapView.layer.cornerRadius = mapView.frame.height / 2
            view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
       
        }
      
        
        func didReceive(_ notification: UNNotification) {
            print("eeeee")
          
            self.renderedMap("uuu", subtitle: "iii", latitude: 33.507424, longitude: 11.108472)
            
            
        }
        
}



extension MapViewRendered : MKMapViewDelegate {
    
   
    
    fileprivate func renderedMap(_ title:String, subtitle:String, latitude:Double, longitude:Double) {
        newLocation.latitude = latitude
        newLocation.longitude = longitude
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: newLocation, span: span)
        
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = newLocation
        annotation.title = "Bonjour,"//title
        annotation.subtitle = "départ ici !"//subtitle
        
        mapView.addAnnotation(annotation)
    }
}

