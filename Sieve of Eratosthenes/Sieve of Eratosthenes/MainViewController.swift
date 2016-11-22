//
//  MainViewController.swift
//  Sieve of Eratosthenes
//
//  Created by Computer Science on 11/21/16.
//  Copyright © 2016 Computer Science. All rights reserved.
//

import UIKit
import Device

class MainViewController: UIViewController {
    
    //Text Field for User to enter in Number > 1 && < 121
    @IBOutlet weak var mainTextField: UITextField!
    
    //Frame for the text field
    var textFrame: CGRect!
    
    //Done Button
    @IBOutlet weak var doneButton: UIButton!
    
    //Constraint between text field and instructions
    @IBOutlet weak var betweenConstraint: NSLayoutConstraint!
    
    //Constraints for text field
    @IBOutlet weak var mainTxtconstraintHor: NSLayoutConstraint!
    @IBOutlet weak var mainTxtconstraintVer: NSLayoutConstraint!
    
    //Number to send to next View Controller
    var numberToSend: Int!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Device Type
        let deviceType = UIDevice.current.deviceType
        
        switch deviceType {
        case .iPhone6SPlus: betweenConstraint.constant = 100
        case .iPhone7Plus: betweenConstraint.constant = 100
        case .iPhone6: betweenConstraint.constant = 75
        case .iPhone7: betweenConstraint.constant = 75
        default: print("Check other available cases of DeviceType")
        }
        
        
        //Height and Width of screen
        let height = self.view.frame.size.height
        let width = self.view.frame.size.width

        //Set up textFrame
        textFrame = CGRect(x: width/5, y: height/5, width: width * (3/5), height: 200)
        
        //Set up textField
        mainTextField.frame = textFrame
        mainTextField.layer.borderColor = UIColor.black.cgColor
        mainTextField.layer.borderWidth = 1.5
        mainTextField.layer.cornerRadius = 5.0
        mainTextField.becomeFirstResponder()
        
        //Set up Done Button
        doneButton.layer.borderColor = UIColor.black.cgColor
        doneButton.layer.borderWidth = 1.5
        doneButton.layer.cornerRadius = 5.0
        doneButton.setTitle("DONE", for: .normal)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func doneAction(_ sender: Any) {
        
        //Set number in text field to be sent to next view controller
        let number = Int(mainTextField.text!)
        
        if mainTextField.text! == "" || number! > 120 || number! < 2{
            //Show alert to user that they need to input the correct number
            let alert = UIAlertController(title: "ERROR", message: "Please Enter a number between 2 and 120", preferredStyle: .alert)
     
            alert.addAction(UIAlertAction(title: "OKAY", style: .cancel, handler: { (action) in
                
            }))

            self.present(alert, animated: true, completion: nil)
        }
        else{
            numberToSend = number
        }
        
        
        //Perform segue
        self.performSegue(withIdentifier: "Segue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc: NumbersViewController = segue.destination as! NumbersViewController
        vc.number = numberToSend
        
    }

    
    
    

}
