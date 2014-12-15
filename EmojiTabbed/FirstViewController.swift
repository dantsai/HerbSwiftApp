//
//  FirstViewController.swift
//  EmojiTabbed
//
//  Created by Micah on 12/9/14.
//  Copyright (c) 2014 Micah. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FirstViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,
    MKMapViewDelegate,
    CLLocationManagerDelegate{

    let locationManager = CLLocationManager()

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var descriptionField: UITextField!
    
    let pickerData = ["Fennel", "Mint", "Parsley", "Sage", "Rosemary", "Thyme"]

    var herb = Herbs()
    
    var location = CLLocationCoordinate2D(
        latitude: 37.8717,
        longitude: -122.2728
    )
    var currentPickerVal:String = "Fennel"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

        pickerView.dataSource = self
        pickerView.delegate = self
        
        if (locationManager.location != nil) {
            location = CLLocationCoordinate2D(
                latitude:locationManager.location.coordinate.latitude,
                longitude: locationManager.location.coordinate.longitude)
        }

        
        let span = MKCoordinateSpanMake(0.0075, 0.0075)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.setCoordinate(location)
        annotation.title = "Drag pin to locate herb"
//        annotation.subtitle = "Drag pin to locate herb"
        mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // what happens when we click submit?
    @IBAction func submitHerb(sender: AnyObject) {
        herbs.toAdd.append(Herb(newlat: location.latitude, newlong: location.longitude, newdescription: descriptionField.text, newtype: currentPickerVal))
        println("lat: \(location.latitude), long: \(location.longitude), desc: \(descriptionField.text), type: \(currentPickerVal)")
    }
    
    // implement picker delegate
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return pickerData[row]
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentPickerVal = pickerData[row]
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if annotation is MKPointAnnotation {
            let pinAnnotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myPin")
            
            pinAnnotationView.pinColor = .Purple
            pinAnnotationView.draggable = true
            pinAnnotationView.canShowCallout = true
            pinAnnotationView.animatesDrop = true
            
            return pinAnnotationView
        }
        
        return nil
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, didChangeDragState newState: MKAnnotationViewDragState, fromOldState oldState: MKAnnotationViewDragState) {
        if newState == MKAnnotationViewDragState.Ending || newState == MKAnnotationViewDragState.Canceling
        {
            location = view.annotation.coordinate
            println("new long: \(location.longitude). new lat: \(location.latitude)" )
        }
    }

}

