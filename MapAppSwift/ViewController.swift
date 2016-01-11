//
//  ViewController.swift
//  MapAppSwift
//
//  Created by Matt Deuschle on 1/8/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView!
    @IBOutlet var segmentControl: UISegmentedControl!

    var mangaer = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // location where pin is dropped
        let pinLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(37.3092293, -122.1136845)

        // pin annotations
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = pinLocation
        objectAnnotation.title = "Apple"
        objectAnnotation.subtitle = "Curpertino, CA"
        self.mapView.addAnnotation(objectAnnotation)
    }

    @IBAction func directions(sender: AnyObject) {

        // set up URL link for directions
        UIApplication.sharedApplication().openURL(NSURL(string: "http://maps.apple.com/maps?daddr=37.3092293,-122.1136845")!)

    }

    @IBAction func mapType(sender: AnyObject) {

        if (segmentControl.selectedSegmentIndex == 0)
        {
            mapView.mapType = MKMapType.Standard
        }
        if (segmentControl.selectedSegmentIndex == 1)
        {
            mapView.mapType = MKMapType.Satellite
        }
        if (segmentControl.selectedSegmentIndex == 2)
        {
            mapView.mapType = MKMapType.Hybrid
        }

    }

    @IBAction func locateMe(sender: AnyObject) {

        // trigger the locate me button
        mangaer.delegate = self
        mangaer.desiredAccuracy = kCLLocationAccuracyBest
        mangaer.requestWhenInUseAuthorization()
        mangaer.startUpdatingLocation()
        mapView.showsUserLocation = true

    }

    //once we get user location, set up zoom effect
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let userLocation:CLLocation = locations[0] as CLLocation

        // once we get location, stop updating so it will display
        manager.stopUpdatingLocation()

        // get long and lat of th "userLocation"
        let location = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)

        // how far to zoom in
        let span = MKCoordinateSpanMake(0.5, 0.5)

        // set up region of zoom
        let region = MKCoordinateRegion(center: location, span: span)

        mapView.setRegion(region, animated: true)

    }











}

