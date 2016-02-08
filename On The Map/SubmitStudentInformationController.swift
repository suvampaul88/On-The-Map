//
//  SubmitStudentInformationController.swift
//  On The Map
//
//  Created by Suvam Paul on 1/29/16.
//  Copyright © 2016 Suvam Paul. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class SubmitStudentInformationController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var whereAreYouStudying: UILabel!
    @IBOutlet weak var enterURL: UITextField!
    @IBOutlet weak var enterYorLocation: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var findOnTheMap: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    
    var coordinates = CLLocationCoordinate2D()

    override func viewDidLoad() {

        super.viewDidLoad()
        
        enterYorLocation.delegate = self
        enterURL.delegate = self
        
        enterURL.hidden = true
        submitButton.hidden = true
        mapView.hidden = true
        
        whereAreYouStudying.text = "Where Are You Studing Today?"
        enterYorLocation.text = "Enter Your Location Here"
    }
    
    
    @IBAction func findOnTheMapTask(sender: AnyObject) {

        let forwardGeoCode = CLGeocoder()

        forwardGeoCode.geocodeAddressString(enterYorLocation.text!, completionHandler: {location, error -> Void in
            if error != nil {
                let alert = UIAlertController(title: "Failed to find location", message: error?.description, preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                    // Do nothing
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
            if let location = location?.first {
                
                self.whereAreYouStudying.hidden = true
                self.enterYorLocation.hidden = true
                self.findOnTheMap.hidden = true
                
                self.mapView.hidden = false
                self.enterURL.hidden = false
                self.submitButton.hidden = false
                
                self.enterURL.text = "Enter your URL and submit"
                
                self.coordinates = location.location!.coordinate

                let annotation = MKPointAnnotation()
                annotation.coordinate = self.coordinates
                self.mapView.addAnnotation(annotation)
                self.mapView.centerCoordinate = annotation.coordinate
                
            }

        })

    }

    
    @IBAction func submitInfoTask(sender: AnyObject) {
        
        if self.enterURL.text! == "" {
            
            let alert = UIAlertController(title: "URL Empty", message: "Please Enter A Valid URL", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                // Do nothing
            }))
            self.presentViewController(alert, animated: true, completion: nil)
            
        } else {
            
            ParseClient.sharedInstance().postStudentLocations(self.enterYorLocation.text!, mediaURL: self.enterURL.text!, latitude:
                self.coordinates.latitude, longitude: self.coordinates.longitude) {(success, createdAt, error) in
                    
                    if success {
                        
                        print("Location posted at \(createdAt!)")
                        self.dismissViewControllerAnimated(true, completion: nil)
                        
                    } else {
                        self.displayError(error)
                    }
            }
            
        }
    
    }
    
    
    func displayError(errorString: NSError?) {
        dispatch_async(dispatch_get_main_queue(), {
            if let errorString = errorString {
                print(errorString)
            }
        })
    }
    
    //functions for textfield
    
    //keyboard disappears when return button is pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    
        return true;
    }
    
    //dismiss keyboard
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }

}
