//
//  Algorithm.swift
//  Sieve of Eratosthenes
//
//  Created by Adrian Humphrey on 11/12/16.
//  Copyright © 2016 Adrian Humphrey. All rights reserved.
//

import Foundation
import UIKit

protocol AnimationDelegate :class{
    func changeViewColor(_ tag: Int, color: UIColor, prime: Bool)
    
}

class Algorithm{
    
    //Delegate
    weak var delegate :AnimationDelegate?
    
    //Number that is passed in to calculate
    var numToCalc: Int
    
    //Array of Int that will hold all of the prime numbers calculated
    var intArray: [Int] = []
    
    //Array of UIColors to animate views with
    var colorArray: [UIColor] = []
    
    //Timer1
    var myTimer: Timer
    
    //Timer2
    var myTimer2: Timer
    
    //Timer 3
    var mytimer3: Timer
    
    //variable that will hold the squareroot of n
    var n: Int?
    
    
    
    //Initialization
    init(number: Int){
        
        numToCalc = number
        
        //Set up Tiemrs
        myTimer = Timer()
        myTimer2 = Timer()
        mytimer3 = Timer()
        
        //Fill color array
        fillcolorArray()
        
    }
    
    //With the number provided and using the Sieve of Eratosthenes algorithm
    func calculatePrimes(){
        
        let number = numToCalc
        var n = findClosetRoot(number: Double(number))
        self.n = n
        
        if self.n! < number {
            n = number + 1
        }
        
        //Check if the number is greater than 121 or less than 2
        if (number < 2) || (number > 121){
            return
        }
        
        //Temp array of integers, initializes with numbers - 1
        var array: [Int] = []
        
        //Add all integers under number to array of integers, array[0] = 2
        for i in 2...number{
            array.append(i)
        }
        
        //Array of primes to be returned
        var primes: [Int] = []
        
        //Array of booleans to keep integers indexed
        var boolArr: [Bool] = []
        
        /*Add bool values for the number of numbers that are in temp array of Integers
         Let A be an array of Boolean values, indexed by integers 2 to n,
         initially all set to true. */
        
        for _ in 1...number - 1{
            boolArr.append(true)
        }
        
        
        
        //Sieve of Eratosthenes algorithm
        
        //for i = 2, 3, 4, ..., not exceeding √n:
        for i in 2...n - 1{
            
            //if A[i] is true:
            if boolArr[i - 2] == true {
                
                //for j = i2, i2+i, i2+2i, i2+3i, ..., not exceeding n :
                //This is equivalent to checking if j is divisible by i, but j != i
                for j in 0...array.count{
                    
                    if (j % i == 0) && (j != i) && (j != 0){
                        
                        //A[j] := false
                        boolArr[j-2] = false
                        
                        
                        
                    }
                }
            }
        }
        
        //Iterate through through boolean array, and add prime numbers to new array
        for x in 0...boolArr.count - 1{
            
            //If index hold true,
            if boolArr[x] == true{
                
                //add the value from array of Ints to array of prime numbers
                primes.append(array[x])
            }
        }
        
        print(primes)
        
        self.intArray = primes
        
        //TODO: call this as soon as the user presses eneter with the number that they inputed
        self.myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(animateNonPrimes), userInfo: nil, repeats: false)
        
        
        
        
    }
    
    
    //Find the square root, round down
    func findClosetRoot(number: Double) -> Int{
        
        let square = sqrt(number)
        let floored = floor(square)
        
        return Int(floored)
    }
    
    //Fills the color array to keep track of colors easy
    func fillcolorArray(){
        
        //Red 0
        colorArray.append(UIColor(red: 255, green: 0, blue: 0, alpha: 1))
        
        //Blue 1
        colorArray.append(UIColor(red: 0, green: 0, blue: 255, alpha: 1))
        
        //Green 2
        colorArray.append(UIColor(red: 0, green: 255, blue: 0, alpha: 1))
        
        //Pinkish Purple 3
        colorArray.append(UIColor(red: 255, green: 0, blue: 255, alpha: 1))
        
        //Yellow 4
        colorArray.append(UIColor(red: 255, green: 255, blue: 0, alpha: 1))
        
        //Light Blue 5
        colorArray.append(UIColor.orange)
        
        //Light Orange 6
        colorArray.append(UIColor(red: 255, green: 192, blue: 96, alpha: 1))
        
        //Light Purple 7
        colorArray.append(UIColor(red: 255, green: 96, blue: 255, alpha: 1))
        
        //Light Green 8
        colorArray.append(UIColor(red: 160, green: 255, blue: 96, alpha: 1))
        
        //light-Dark Blue 9
        colorArray.append(UIColor(red: 64, green: 128, blue: 255, alpha: 1))
        
        //Orange 10
        colorArray.append(UIColor.orange)
        
        //Brown 11
        colorArray.append(UIColor.brown)
        
    }
    
    @objc func animateNonPrimes(){
        
        //Timer count
        var timerCount = 0
        //A for loop with different timers that will call animateMultiple right after one is done
        if let n = self.n{
            for i in self.intArray{
                
                if i >= self.n!{
                    break
                }
                
                
                let interval: Double = Double(timerCount * 2)
                
                myTimer2 = Timer.scheduledTimer(withTimeInterval:interval, repeats: false, block: { (timer) in
                    self.animateMultipile(i: i)
                    
                })
                timerCount+=1
             
                
                
            }
        }
        
        
        func animatePrimes(){
            
            
            
        }
        
        
    }
    
    func animateMultipile(i: Int){
        
        //Animate the first multiple
        delegate?.changeViewColor(i, color: self.colorArray[i - 2], prime: true)
        
        //Delay for a half a second then animate every mulitple of
        var value: Double = 0
        for j in i...self.n! * self.n!{
            mytimer3 = Timer.scheduledTimer(withTimeInterval: TimeInterval(value), repeats: false, block: { (timer) in
                self.delegate?.changeViewColor(i * j, color: self.colorArray[i - 2], prime: false)
                
            })
            value += 0.04
        }
        
    }
    
    
    /**
     Executes the closure on the main queue after a set amount of seconds.
     
     - parameter delay:   Delay in seconds
     - parameter closure: Code to execute after delay
     */
    
    func delay(_ delay: Double, closure: @escaping ()->()){
        //let when = DispatchTime.now() + delay
        Thread.sleep(forTimeInterval: 1.0)
        
    }
    
}


/*
 Algorithm
 Input: an integer n > 1
 
 Let A be an array of Boolean values, indexed by integers 2 to n,
 initially all set to true.
 
 for i = 2, 3, 4, ..., not exceeding √n:
 if A[i] is true:
 for j = i2, i2+i, i2+2i, i2+3i, ..., not exceeding n :
 A[j] := false
 
 Output: all i such that A[i] is true.
 
 */
