//
//  TableViewController.swift
//  On The Map
//
//  Created by Suvam Paul on 1/25/16.
//  Copyright © 2016 Suvam Paul. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UITableViewController {
    
    
    @IBOutlet weak var loutoutButton: UIBarButtonItem!
        
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        
        renderStudentLocationsInTable()
        
    }
    
    
    @IBAction func loutoutUdacity(sender: AnyObject) {
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

    
    @IBAction func refreshStudentLocationsData(sender: AnyObject) {
        renderStudentLocationsInTable()
    }
    
    
    
    func showAlertFailure(error: NSError?) {
        let alert = UIAlertController(title: "Failed to get student locations data", message: error?.description, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
            // Do nothing
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    func displayError(errorString: NSError?) {
        dispatch_async(dispatch_get_main_queue(), {
            if let errorString = errorString {
                print(errorString)
            }
        })
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StudentInfo.locations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("studentLocationTableViewCell") as UITableViewCell!
        let location =  StudentInfo.locations[indexPath.row]
        
        cell.textLabel?.text = "\(location.firstName) \(location.lastName)"
        cell.imageView?.image = UIImage(named: "Pin")
        cell.detailTextLabel?.text = location.mediaURL
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let app = UIApplication.sharedApplication()
        let toOpen = StudentInfo.locations[indexPath.row].mediaURL
            app.openURL(NSURL(string:toOpen)!)
    }
    
    func renderStudentLocationsInTable() {
        
        ParseClient.sharedInstance().getStudentLocations() { success, locations, error in
            if let locations = locations {
                dispatch_async(dispatch_get_main_queue()) {
                    StudentInfo.locations = locations
                    self.tableView.reloadData()
                }
            } else {
                print(error)
                self.showAlertFailure(error)
            }
        }
        
    }
}