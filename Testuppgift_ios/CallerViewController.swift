//
//  CallerViewController.swift
//  Testuppgift_ios
//
//  Created by Paul Griffin on 12/07/16.
//  Copyright © 2016 Paul. All rights reserved.
//

import UIKit
//
var selectedPhoneNumber:String?
class CallerViewController: UIViewController {
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboardOnTap()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(animated: Bool) {
        //If a number is set copy it into the textfield and clear the global number for next time
        if let number = selectedPhoneNumber{
            phoneNumberTextField.text = number
            selectedPhoneNumber = nil
        }
    }
    
    @IBAction func callButtonPressed(sender: AnyObject) {
        if let number = self.phoneNumberTextField.text,
            let encodedNumber = number.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.decimalDigitCharacterSet()),//Handle special characters
            let url = NSURL(string: "tel:"+encodedNumber) where
            UIApplication.sharedApplication().canOpenURL(url){
            
            if number.characters.count == 0{
                showError("Cannot call empty number")
            }else{
                //Configure alert controller
                let alertController = UIAlertController(title: "Make call", message: "To "+number, preferredStyle: .Alert)
                let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action) in
                    self.errorLabel.hidden = true
                }
                let callAction = UIAlertAction(title: "Call", style: .Default) { (action) in
                    UIApplication.sharedApplication().openURL(url)
                    self.errorLabel.hidden = true
                }
                alertController.addAction(cancelAction)
                alertController.addAction(callAction)
                
                self.presentViewController(alertController, animated: true) {}
            }
        }else{
            //for some reason we could not place the call
            showError("Failed to make call")
        }
    }
    func showError(message:String){
        UIView.transitionWithView(self.errorLabel, duration: 0.2, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.errorLabel.hidden = false
            }, completion: nil)
        self.errorLabel.text = message
    }
}

