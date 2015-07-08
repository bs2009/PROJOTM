//
//  InfoPostingViewController.swift
//  P4
//
//  Created by William Song on 6/19/15.
//  Copyright (c) 2015 Bill Song. All rights reserved.
//
import Foundation
import MapKit
import UIKit

class InfoPostingViewController: UIViewController, UITextFieldDelegate, UIApplicationDelegate {
    
    @IBOutlet weak var findOnTheMapButton: UIButton!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var CancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTextField.backgroundColor = UIColor.darkGrayColor()
        locationTextField.delegate = self

    }
    
    // Returns to previous Controller
    @IBAction func cancelButtonTouchUp(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    // Locates address entered and sends to URLMapViewController
    @IBAction func findOnMap(sender: AnyObject) {
        let address = locationTextField.text as String
        var geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks: [AnyObject]!, error: NSError!) -> Void in
            if let placemark = placemarks?[0] as? CLPlacemark {
                
                let mediaURLViewController = self.storyboard?.instantiateViewControllerWithIdentifier("SubmitInfo") as! SubmissionInfoViewController
                
                // send over the placemark
                mediaURLViewController.geolocation = placemark
                mediaURLViewController.mapString = address
                self.presentViewController(mediaURLViewController, animated: true, completion: nil)
                
            } else {
              
                // can't find the location, request user to re-enter
                var invalidAddress = UIAlertView()
               
                invalidAddress.title = "Invalid Location"
                invalidAddress.message = "Unable to find location. Please re-enter."
                invalidAddress.addButtonWithTitle("OK")
                invalidAddress.show()
            }
        })
    }
    
 
    // Dismiss keyboard if return key pressed
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if locationTextField.isFirstResponder() {
            locationTextField.resignFirstResponder()
        }
        return true
    }
}