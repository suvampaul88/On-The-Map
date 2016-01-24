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
    
    

    var locations: [StudentLocations] = [StudentLocations]()
    var annotations = [MKPointAnnotation]()
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        mapView.delegate = self
        
        
//        self.parentViewController!.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Reply, target: self, action: "logoutButtonTouchUp")
//        
//        func logoutButtonTouchUp() {
//            self.dismissViewControllerAnimated(true, completion: nil)
//        }
 
        ParseClient.sharedInstance().getStudentLocations() { locations, error in
            if let locations = locations {
                dispatch_async(dispatch_get_main_queue()) {
                    self.locations = locations
                    self.mapView.reloadInputViews()
                    self.setLocationsOnMap()
                }
            } else {
                print(error)
            }
        }
        
    }
    
    
    func setLocationsOnMap () {
        
        var annotations = [MKPointAnnotation]()
        
        for location in locations {
            
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
//                self.completeLogout()
                //alternatives
                self.dismissViewControllerAnimated(true, completion: nil)
            } else {
                self.displayError(error)
            }
        }
    }
    
    
    func completeLogout() {
        dispatch_async(dispatch_get_main_queue(), {
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("SigninPage") as! LoginViewController
            self.presentViewController(controller, animated: true, completion: nil)
        })
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
    
    
    // This delegate method is implemented to respond to taps. It opens the system browser
    // to the URL specified in the annotationViews subtitle property.
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.sharedApplication()
            if let toOpen = view.annotation?.subtitle! {
                app.openURL(NSURL(string: toOpen)!)
            }
        }
    }
    
}