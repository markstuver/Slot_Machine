//
//  Factory.swift
//  SlotMachine
//
//  Created by Mark Stuver on 10/18/14.
//  Copyright (c) 2014 Mark Stuver. All rights reserved.
//

import Foundation
import UIKit

// Factory Design Pattern - Factory Class sits inbetween the Model (Slot) and the viewController. Cleaner so that there is not so much code in VC
class Factory {
    
    /*
    A Class Function: 'class func createSlots()
    is called like this: 'Factory.createSlots()' It does not need an instance and in this case it simply returns an array of arrays
    
    An Instance Function: 'func createSlot()'
            is called like this: 'var factoryInstance = Factory()'  An instance needs to be created first
                                 'factoryInstance.createSlot()' Then the function can be called on the instance  */
    

    // Class Function that Returns an Array of Slot Arrays
    class func createSlots()-> [[Slot]] {
        
        let kNumberOfSlots = 3
        let kNumberOfContainers = 3
        // instance of an Array that holds an Array of type Slots.
        var slots: [[Slot]] = []
        
        /* Creating an Array of Arrays - will look like this:
        
                slotArray1/Column 1       slotArray2/Column 2    slotArray3/Column 3
        slots = [[slot1, slot2, slot3], [slot4, slot5, slot6], [slot7, slot8, slot9]]

        this For Loop will Create 3 Container Arrays. Each Container Array will have 3 Slot Arrays */
        for var containerNumber = 0; containerNumber < kNumberOfContainers; ++containerNumber {   // Will Run Three Times
            
            // Array that will hold a set of three Slots
            var slotArray:[Slot] = []
            
            // This For Loop will Create 3 Slot instances and load them into a container Array
            for var slotNumber = 0; slotNumber < kNumberOfSlots; ++slotNumber { // Will Run Three times for each Container (3 total containers)
                
                // Call createSlot() Function to create an instance of Slot
                var slot = Factory.createSlot(slotArray)
                
            // put Slot instance into the slotArray
            slotArray.append(slot)
                
                
            }
            // put slotArray into slots (container) Array
            slots.append(slotArray)
        }
        
        return slots
    }
    
    
    
    // Class Function Creates Slot Instances
    // Pass slotArray into createSlot to make sure the same card/value is not present in the same slotArray(Column)
    class func createSlot (currentCards: [Slot])-> Slot {
        
        // Array that holds the current cards
        var currentCardValues:[Int] = []
        
        // Iterate through all the slot instances that are in the currentCard array that was passed into the method
        for slot in currentCards {
            
            //Grab the value of the current slot instance and add it to the currentCardValues Array
            currentCardValues.append(slot.value)
        }
        
        // Create a random Integer number instance
        var randomNumber = Int(arc4random_uniform(UInt32(13)))
        
        // Check if the currentCardValues Array, currently contains the randomNumber generated
        //(randomNumber  + 1) is because we want numbers 1 - 13 but the arc4random function is randomly created a number between 0 - 12
        // 'while contains(container, instance to compare)' - this function will compare the values in the container/currentCardValues array, to the random number that was created for the randomNumber variable. If the value in the container equals the value of randomNumber, it will execute the code in the curly brackets.
        while contains(currentCardValues, randomNumber + 1) {
            // If a value in the currentCardValues array equals the randomNumber + 1, another random number is assigned to randomNumber instead.
            randomNumber = Int(arc4random_uniform(UInt32(13)))
        }
        
        // Create an instance of Slot
        var slot:Slot
        
        // Determines which slot will be used based on the randomNumber
        switch randomNumber {
        
        // pass parameters into Slot instance based on random number
        case 0: slot = Slot(value: 1, image: UIImage(named: "Ace"), isRed: true)
        case 1: slot = Slot(value: 2, image: UIImage(named: "Eight"), isRed: false)
        case 2: slot = Slot(value: 3, image: UIImage(named: "Five"), isRed: false)
        case 3: slot = Slot(value: 4, image: UIImage(named: "Four"), isRed: true)
        case 4: slot = Slot(value: 5, image: UIImage(named: "Jack"), isRed: false)
        case 5: slot = Slot(value: 6, image: UIImage(named: "King"), isRed: true)
        case 6: slot = Slot(value: 7, image: UIImage(named: "Nine"), isRed: false)
        case 7: slot = Slot(value: 8, image: UIImage(named: "Queen"), isRed: false)
        case 8: slot = Slot(value: 9, image: UIImage(named: "Seven"), isRed: true)
        case 9: slot = Slot(value: 10, image: UIImage(named: "Six"), isRed: false)
        case 10: slot = Slot(value: 11, image: UIImage(named: "Ten"), isRed: true)
        case 11: slot = Slot(value: 12, image: UIImage(named: "Three"), isRed: true)
        case 12: slot = Slot(value: 13, image: UIImage(named: "Two"), isRed: true)
        default: slot = Slot(value: 0, image: UIImage(named: "Ace"), isRed: true)
        }
        return slot
    }
    
    
    
    
    
    
    
}