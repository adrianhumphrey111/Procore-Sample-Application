//
//  ViewController.swift
//  Sieve of Eratosthenes
//
//  Created by Computer Science on 11/10/16.
//  Copyright © 2016 Adrian Humphrey. All rights reserved.
//  Will Do all layouts through code and not story board

import UIKit
import CoreGraphics

class ViewController: UIViewController, AnimationDelegate {
    
    //textField for number input from user
    var chosenNumberTextField: UITextField!
    
    //textField frame
    var textFieldFrame: CGRect!
    
    //View on the left side of screen that will hold all of the squares that animate will finding primes
    var squareView: UIView!
    
    //View on the right side of the screen that will hold the prime numbers as an output
    var primeView: UIView!
    
    //Delegate Method
    func changeViewColor(_ tag: Int, color: UIColor){
        
        if let view: SquareView = self.squareView.viewWithTag(tag) as! SquareView?{
            
                 view.changeColor(color: color)
        
           
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
 
        //initialize both views ontop of View Controller, 20px from left, 20px from top, 2/3 of screen
        squareView = UIView(frame: CGRect(x: 10, y: 20, width: self.view.frame.size.width - 10 , height: self.view.frame.size.height - 20))
        
        //primeView = UIView(frame: CGRect(x: self.view.frame.width * (2/3) , y: 20, width: self.view.frame.size.width * (1/3) - 10, height: self.view.frame.size.height ))

        
        view.addSubview(squareView)
        //view.addSubview(primeView)
        
        layoutViews(count: 121)
        
        //Wait 3 second then change the color
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when){
            //testView.changeColor(color: UIColor.red)
        }
        
        
        //Dismiss keyboard on tap around
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        //Keybopard should come up as soon as view loads
        for textField in self.view.subviews where textField is UITextField {
            
            //Ask user to input a number that does not exceed 121 not including 0 or one
            textField.resignFirstResponder()
        }
        
        //Width and height for future use, text field as well as drawing views as squares
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        
        //Text field frame
        textFieldFrame = CGRect(x: width/4, y: height/4, width: width/2, height: height/6)
        
        //textField for desired number
        chosenNumberTextField = UITextField(frame: textFieldFrame)
        chosenNumberTextField.borderStyle = .line
        
        //Add textfield to view
        //self.view.addSubview(chosenNumberTextField)
        
        
        //Calculate primes
        let algorithm = Algorithm(number: 121)
        algorithm.delegate = self
        
        algorithm.calculatePrimes()
        

        
        //algorithm.animateViews()
        
        //Once you have the prime numbers draw views and animate color synchranization
        
    }
    
    func layoutViews(count: Int){
        
        //Test creating more than one view you have to keep an index
        var yindex = 0
        var xindex = 1
        //For loop from one to the number that was imported
        for i in 1...count{
            //If the count goes over 10, reset x, and move the y down
            if i % 10 == 0{
                print(i)
                
                //Add to the yindex
                yindex+=1
                
                //reset the x index
                xindex = 0
                
            }
                
            //divide the width of the test view by ten minus the number of squars times 5
            let width = self.squareView.frame.size.width - 10 * 5
            
            //set the size TODO: divide by count + 1
            let size:CGFloat = width/11
            //set x according to index
            let x: CGFloat = (size * CGFloat(xindex)) + (CGFloat(xindex) * 5)
            let y: CGFloat = (size * CGFloat(yindex)) + (CGFloat(yindex) * 5)
            
            let frame = CGRect(x: x, y: y, width: size, height: size)
            
            let testView: SquareView = SquareView(n: i + 1, c: UIColor.gray, p: true, f: frame)
            
            //Add a tag to the view
            testView.tag = i + 1
            self.squareView.addSubview(testView)
            
            xindex+=1
            
        }
        /* This is how you access views as sqaure view and change them
 
        for view in (self.squareView.subviews as? [UIView])!{
            
            var view1 = view as! SquareView
            //if the view has an even tag, change its number to red
            if view.tag % 2 == 0 {
                
                view1.changeColor(color: UIColor.red)
            }
            
        }
 
 */

        
    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideKeyboard() {
        view.endEditing(true)
    }
    
    // For pressing return on the keyboard to dismiss keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        for textField in self.view.subviews where textField is UITextField {
            textField.resignFirstResponder()
        }
        return true
    }


}

