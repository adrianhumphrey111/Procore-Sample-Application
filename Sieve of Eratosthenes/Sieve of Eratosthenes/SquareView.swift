//
//  SquareView.swift
//  Sieve of Eratosthenes
//
//  Created by Adrian Humphrey on 11/13/16.
//  Copyright © 2016 Adrian Humphrey. All rights reserved.
//

import UIKit
import Device

class SquareView: UIView {


    //Number that is in the middle of the view
    var number: Int!
    
    //Color the view should be drawn with
    var color: UIColor
    
    //Is this number that was passed in a prime number or not
    var prime: Bool!
    
    //cgrect that you would like to initialize the view with
    var frameOne: CGRect!
    
    //Label to hold the number that was passed in
    var numberLabel: UILabel!
    
    init(n: Int, c: UIColor, p: Bool, f: CGRect){
        
        self.number = n
        self.color = c
        self.prime = p
        self.frameOne = f
        
        super.init(frame: self.frameOne)
        
        self.backgroundColor = self.color
        
        addNumber()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    override func draw(_ rect: CGRect) {

    }
 
 */
    
    func addNumber(){
        
        //Add number label in the middle to the view
        numberLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frameOne.width, height: self.frameOne.height))
        
        //Set title
        numberLabel.text = String(self.number)
        
        if(self.number > 99){
            numberLabel.font = UIFont(name: "AlNile", size: 17.0)
        }
        else{
            numberLabel.font = UIFont(name: "AlNile", size: 20.0)
        }
        

        //Add the label
        self.addSubview(numberLabel)
    }
    
    //Gab color that was passed in and redraw square with this color
    func changeColor(color: UIColor){
       
        self.color = color
  
        //redraw view
        self.backgroundColor = color
        
        
    }
    
    //For the prime numbers
    func changeFontColor(){
        
        let fontColor = UIColor.white
        self.numberLabel.textColor = fontColor
        
    }
    
    func defaultView(){
        
        //Change color back to grey
        self.backgroundColor = UIColor.gray
        
        //Change label color back to black
        self.numberLabel.textColor = UIColor.black
    }
    
    //For the prime numbers in Prime view. Need to decrease the size
    func changeLabelSize(){
        let deviceType = UIDevice.current.deviceType
        
        switch deviceType {
        case .iPhone5: numberLabel.font = UIFont(name: "AlNile", size: 12.0)
        case .iPhone6: numberLabel.font = UIFont(name: "AlNile", size: 15.0)
        default: break
        }
        
        
    }
    
    

}
