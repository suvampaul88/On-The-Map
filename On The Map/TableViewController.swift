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
    
    var locations: [StudentLocations] = [StudentLocations]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        
        ParseClient.sharedInstance().getStudentLocations() { locations, error in
            if let locations = locations {
                dispatch_async(dispatch_get_main_queue()) {
                    self.locations = locations
                    self.tableView.reloadData()
                }
            } else {
                print(error)
            }
        }
        
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

    
    func displayError(errorString: NSError?) {
        dispatch_async(dispatch_get_main_queue(), {
            if let errorString = errorString {
                print(errorString)
            }
        })
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("studentLocationTableViewCell") as UITableViewCell!
        let location = locations[indexPath.row]
        
        cell.textLabel?.text = "\(location.firstName) \(location.lastName)"
        cell.imageView?.image = UIImage(named: "Pin")
        cell.detailTextLabel?.text = location.mediaURL
        return cell
    }
    
    
    //NOTE: I can't seem to get to details view controller from table view
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let app = UIApplication.sharedApplication()
        let toOpen = locations[indexPath.row].mediaURL
            app.openURL(NSURL(string:toOpen)!)
    }
}