//
//  ViewController.swift
//  Sieve of Eratosthenes
//
//  Created by Adrian Humphrey on 11/10/16.
//  Copyright © 2016 Adrian Humphrey. All rights reserved.
//  Will Do all layouts through code and not story board

import UIKit
import CoreGraphics
import Device



class NumbersViewController: UIViewController, AnimationDelegate {
    
    //textField for number input from user
    var chosenNumberTextField: UITextField!
    
    //textField frame
    var textFieldFrame: CGRect!
    
    //Button to reset and go back to the main view
    @IBOutlet weak var resetButton: UIButton!
    
    //Replay button
    @IBOutlet weak var replayButton: UIButton!
    
    
    //View on the left side of screen that will hold all of the squares that animate will finding primes
    var squareView: UIView!
    
    //View on the right side of the screen that will hold the prime numbers as an output
    var primeView: UIView!
    
    
    //Number passed in
    var number: Int!
    
    //Timer
    var myTimer : Timer!
    
    
    
    //Delegate Methods
    func changeViewColor(_ tag: Int, color: UIColor, prime: Bool){
        
        if let view: SquareView = self.squareView.viewWithTag(tag) as! SquareView?{
            
            view.changeColor(color: color)
            
            if prime {
                //Change the font Color to white
                view.changeFontColor()
                
                //Unhide the prime from the primeview
                unhidePrime(tag)
            }

        }
        
            }
    
    func setUpPrimes(_ arr: [Int]){
        //Animate every prime number that is in the array passed in.
        
        //Test creating more than one view you have to keep an index
        var yindex = 0
        var xindex = 1
        //For loop from one to the number that was imported
        for i in 0...arr.count - 1{
            //If the count goes over 10, reset x, and move the y down
            if i % 12 == 0{
                
                //Add to the yindex
                yindex+=1
                
                //reset the x index
                xindex = 0
                
            }
            
            //divide the width of the test view by ten minus the number of squars times 5
            let width = self.primeView.frame.size.width - 10 * 5
            
            //set the size TODO: divide by count + 1
            let size:CGFloat = width/15
            //set x according to index
            let x: CGFloat = (size * CGFloat(xindex)) + (CGFloat(xindex) * 5)
            let y: CGFloat = (size * CGFloat(yindex)) + (CGFloat(yindex) * 5)
            
            let frame = CGRect(x: x, y: y, width: size, height: size)
            
            let testView: SquareView = SquareView(n: arr[i], c: UIColor.white, p: true, f: frame)
            
            //Add a tag to the view
            testView.tag = arr[i]
            testView.isHidden = true
            self.primeView.addSubview(testView)
            
            
            xindex+=1
            
        }
        
        
    }

    func animatePrimes(_ color: UIColor, arr: [Int]){
        
        //For every integer in array, animate the view, turn the font color white and unhide the prime for primeview
        var timerCount: Double = 0
        var count = 0
        print("Array counr = ", arr.count)
        for i in arr{
            //Last Int in the array
            let last = arr.last!
            
            //Call after a certain timer interval
            let interval: Double = Double(timerCount * 2)
            myTimer = Timer.scheduledTimer(withTimeInterval:interval, repeats: false, block: { (timer) in
                
                if let view: SquareView = self.squareView.viewWithTag(i) as! SquareView?{
                    
                    //Animate only if it is not already animated
                    if view.color == UIColor.gray{
                        //Change color to color that was passed in
                        view.changeColor(color: color)
                        
                        //Change the font to white
                        view.changeFontColor()
                        
                        //Unhide the prime from the prime view
                        self.unhidePrime(i)
                        
                    }
                    
                }
                
            })
            timerCount = timerCount + 0.5
            
            count+=1
            
            //Enable replay button once the views are done animating
            if count == arr.count{
                self.replayButton.isEnabled = true
            }
            
        }
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up reset button
        resetButton.layer.borderColor = UIColor.black.cgColor
        resetButton.layer.borderWidth = 1.5
        resetButton.layer.cornerRadius = 5.0
        resetButton.setTitle("RESET", for: .normal)
        resetButton.isEnabled = true
        
        //Set up replay button
        replayButton.layer.borderColor = UIColor.black.cgColor
        replayButton.layer.borderWidth = 1.5
        replayButton.layer.cornerRadius = 5.0
        replayButton.setTitle("REPLAY", for: .normal)
        replayButton.isEnabled = false
        

        //initialize both views ontop of View Controller, 20px from left, 20px from top, 2/3 of screen
        squareView = UIView(frame: CGRect(x: 25, y: 40, width: self.view.frame.size.width - 10 , height: self.view.frame.size.height * (2/3) - 35))
        squareView.isUserInteractionEnabled = false
        primeView = UIView(frame: CGRect(x: 25 , y: 40 + self.view.frame.size.height * (2/3) - 40 , width: self.view.frame.size.width - 10, height: self.view.frame.size.height * (1/3) - 125 ))
        primeView.isUserInteractionEnabled = false
       
        
        view.addSubview(squareView)
        view.addSubview(primeView)
        
        
        //Width and height for future use, text field as well as drawing views as squares
        let width = self.view.frame.size.width
        let height = self.view.frame.size.height
        
        //Text field frame
        textFieldFrame = CGRect(x: width/4, y: height/4, width: width/2, height: height/6)
        
        //textField for desired number
        chosenNumberTextField = UITextField(frame: textFieldFrame)
        chosenNumberTextField.borderStyle = .line
        
        //Set up Timer
        myTimer = Timer()
        
        //Layout the views
        layoutViews(count: number)
        
        //Calculate primes
        let algorithm = Algorithm(number: number)
        algorithm.delegate = self
        algorithm.calculatePrimes()
        

    }
    
    func layoutViews(count: Int){
        
        //Test creating more than one view you have to keep an index
        var yindex = 0
        var xindex = 1
        //For loop from one to the number that was imported
        for i in 1...count - 1{
            //If the count goes over 10, reset x, and move the y down
            if i % 10 == 0{

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

    }
    


    @IBAction func resetAction(_ sender: Any) {

        self.dismiss(animated: false, completion: nil)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func unhidePrime(_ tag: Int){
        
        if let view: SquareView = self.squareView.viewWithTag(tag) as! SquareView?{
            
            //view.changeColor(color: color)
            for view in self.primeView.subviews {
                let view1 = view as! SquareView
                if view1.tag == tag{
                    //If the device is a iphone5, change the font
                    view1.changeLabelSize()
                    view1.isHidden = false
                }
            }
        }
    }
    
    
    //this replays the animation of the views and the views after hiding them
    @IBAction func replayAction(_ sender: Any) {
        
        //Turn all views back to grey and font back to black
        for view in self.squareView.subviews {
            let view1 = view as! SquareView
            view1.defaultView()
            
        }

        //Hides primes
        for view in self.primeView.subviews {
            view.isHidden = true
        }
    
        //Calculate primes
        let algorithm = Algorithm(number: number)
        algorithm.delegate = self
        algorithm.calculatePrimes()
        
        //Re-disable it
        self.replayButton.isEnabled = false
        
    }
    



}

