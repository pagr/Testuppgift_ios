//
//  SecondViewController.swift
//  Testuppgift_ios
//
//  Created by Paul Griffin on 12/07/16.
//  Copyright © 2016 Paul. All rights reserved.
//

import UIKit
import ContactsUI
class PhoneBookViewController: UIViewController, CNContactPickerDelegate {

    @IBOutlet weak var phoneNumberTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func openPhoneBookButtonPressed(sender: AnyObject) {
        
        let peoplePicker = CNContactPickerViewController()
        peoplePicker.delegate = self
        peoplePicker.predicateForEnablingContact = NSPredicate(format: CNContactPhoneNumbersKey+".@count > 0")
        peoplePicker.displayedPropertyKeys=[CNContactPhoneNumbersKey]
        self.showViewController(peoplePicker, sender: self)
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContactProperty contactProperty: CNContactProperty) {
        
        if let phoneNumber = contactProperty.value as? CNPhoneNumber{
            phoneNumberTextField.text = phoneNumber.stringValue
            selectedPhoneNumber = phoneNumber.stringValue
        }
    }
    
}

