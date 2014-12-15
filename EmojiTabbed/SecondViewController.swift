//
//  SecondViewController.swift
//  EmojiTabbed
//
//  Created by Micah on 12/9/14.
//  Copyright (c) 2014 Micah. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SecondViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    let locationManager = CLLocationManager()

    var location = CLLocationCoordinate2D(
        latitude: 37.8717,
        longitude: -122.2728
    )
    
    @IBOutlet var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        if (locationManager.location != nil) {
            location = CLLocationCoordinate2D(
                latitude:locationManager.location.coordinate.latitude,
                longitude: locationManager.location.coordinate.longitude)
        }

        
        // bigger span region
        let span = MKCoordinateSpanMake(0.01, 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        
        // show all annotations in herbs
        let herbList = herbs.herbList
        for herb in herbList {
            let annotation = MKPointAnnotation()
            annotation.setCoordinate(CLLocationCoordinate2D(latitude: herb.lat, longitude: herb.long))
            annotation.title = herb.type
            mapView.addAnnotation(annotation)
        }
    }

    override func viewWillAppear(animated: Bool) {
        // add all annotations in toAdd
        let toAdd = herbs.toAdd
        for herb in toAdd {
            let annotation = MKPointAnnotation()
            annotation.setCoordinate(CLLocationCoordinate2D(latitude: herb.lat, longitude: herb.long))
            annotation.title = herb.type
            mapView.addAnnotation(annotation)
            herbs.herbList.append(herb)
        }
        // clear toAdd list, now that theyre all in the herblist
        herbs.toAdd=[]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if annotation is MKPointAnnotation {
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            
            switch(annotation.title as String!!) {
                case "Sage","Mint":
                    pinAnnotationView.pinColor = .Purple
                case "Rosemary", "Thyme":
                    pinAnnotationView.pinColor = .Green
                case "Fennel":
                    pinAnnotationView.pinColor = .Red
            default:
                pinAnnotationView.pinColor = .Red
                
            }
            pinAnnotationView.canShowCallout = true
            pinAnnotationView.animatesDrop = true
            
            return pinAnnotationView
        }
        
        return nil
    }

    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as CLPlacemark
                self.displayLocationInfo(pm)
            } else {
                println("Problem with the data received from geocoder")
            }
        })
    }
    func displayLocationInfo(placemark: CLPlacemark) {
        locationManager.stopUpdatingLocation()
        placemark.locality == nil ? println(placemark.locality) : println("")
        placemark.postalCode == nil ? println(placemark.postalCode) : println("")
        placemark.administrativeArea == nil ? println(placemark.administrativeArea) : println("")
    }


}

