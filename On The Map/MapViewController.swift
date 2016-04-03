//
//  MapViewController.swift
//  On The Map
//
//  Created by Suvam Paul on 1/23/16.
//  Copyright © 2016 Suvam Paul. All rights reserved.
//


import Foundation
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var refreshMapViewButton: UIBarButtonItem!
    
    

    var annotations = [MKPointAnnotation]()
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        mapView.delegate = self
        
        getLocationsForMap()
        
    }
    
    
    
    func getLocationsForMap () {
        ParseClient.sharedInstance().getStudentLocations() { success, locations, error in
            if error != nil {
                dispatch_async(dispatch_get_main_queue()) {
                    let alert = UIAlertController(title: "Download Failed", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                        // Do nothing
                    }))
                    self.presentViewController(alert, animated: true, completion: nil)
                }
            } else {
                dispatch_async(dispatch_get_main_queue()) {
                    StudentInfo.locations = locations!
                    self.mapView.reloadInputViews()
                    self.setLocationsOnMap()
                }
                
            }
        }
        
    }
    
    
    func setLocationsOnMap () {
        
        var annotations = [MKPointAnnotation]()
        
        for location in StudentInfo.locations {
            
            let lat = CLLocationDegrees(location.latitude as Float)
            let long = CLLocationDegrees(location.longitude as Float)
            
            // The lat and long are used to create a CLLocationCoordinates2D instance.
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let first = location.firstName as String
            let last = location.lastName as String
            let mediaURL = location.mediaURL as String
            
            // Here we create the annotation and set its coordiate, title, and subtitle properties
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(first) \(last)"
            annotation.subtitle = mediaURL
            
            // Finally we place the annotation in an array of annotations.
            annotations.append(annotation)
            
        }
        
        // When the array is complete, we add the annotations to the map.
        mapView.addAnnotations(annotations)
    }
    
    
    @IBAction func logoutUdacity(sender: AnyObject) {
        UdacityClient.sharedInstance().logoutUdacity() {(success, ID, error) in
            if success {
                dispatch_async(dispatch_get_main_queue(), {
                  self.dismissViewControllerAnimated(true, completion: nil)
                })
            } else {
                self.displayError(error)
            }
        }
    }
    
    
    @IBAction func refreshMapView(sender: AnyObject) {
        getLocationsForMap()
    }

    
    func displayError(errorString: NSError?) {
        dispatch_async(dispatch_get_main_queue(), {
            if let errorString = errorString {
                print(errorString)
            }
        })
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = UIColor.redColor()
            pinView!.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.sharedApplication()
            if let toOpen = view.annotation?.subtitle! {
                app.openURL(NSURL(string: toOpen)!)
            }
        }
    }
    
}