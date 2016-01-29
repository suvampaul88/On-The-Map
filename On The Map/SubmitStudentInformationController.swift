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
    
    
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        enterYorLocation.delegate = self
        enterURL.delegate = self
        
        enterURL.hidden = true
        submitButton.hidden = true
        mapView.hidden = true
        
        whereAreYouStudying.text = "Where Are You Studing?"
        enterYorLocation.text = "Enter Your Location Here"
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
