//
//  SlotBrain.swift
//  SlotMachine
//
//  Created by Mark Stuver on 11/16/14.
//  Copyright (c) 2014 Mark Stuver. All rights reserved.
//

import Foundation

class SlotBrain {
    
    class func unpackSlotsIntoSlotRows (slots: [[Slot]]) -> [[Slot]] {
        
        // Create 3 empty arrays that hold arrays of Slot
        var slotRow1: [Slot] = []
        var slotRow2: [Slot] = []
        var slotRow3: [Slot] = []
        
        
        // Iterate through slots array (passed when function was called)
        for slotArray in slots {
            
            // for-loop using the slotArray used in the for/in method above
            for var index = 0; index < slotArray.count; index++ {
                
                // create instance of the slot of the array current index
                let slot = slotArray[index]
                
                // If the index is 0 (first item of the current column array of slots)
                if index == 0 {
                    // add the current slot to the slotRow1 array
                    slotRow1.append(slot)
                }
                // else.. If the index is 1 (second item of the current column array of slots)
                else if index == 1 {
                    // add the current slot to the slotRow2 array
                    slotRow2.append(slot)
                }
                    
                // else.. If the index is 2 (third item of the current column array of slots)
                else if index == 2 {
                    // add the current slot to the slotRow3 array
                    slotRow3.append(slot)
                }
                // else... print error
                else {
                    println("Error")
                }
            }
        }
        // Create array to hold the arrays of slots
        var slotInRows: [[Slot]] = [slotRow1, slotRow2, slotRow3]
        
        return slotInRows
    }
    
    
    class func computeWinnings(slots: [[Slot]]) -> Int {
        
        //Create instance of the inpackSlotsIntoSlotRows
        var slotsInRows = unpackSlotsIntoSlotRows(slots)
        
        var winnings = 0
        
        var flushWinCount = 0
        var threeOfAKindWinCount = 0
        var straightWinCount = 0
        
        for slotRow in slotsInRows {
    
// FLUSH
            // if checkFlush returns true...
            if checkFlush(slotRow) == true {
                println("flush")
                // add 1 to winnings
                winnings += 1
                // add 1 to flush count
                flushWinCount += 1
            }
            
// THREE IN A ROW
            // if checkThreeInRow returns true...
            if checkThreeInARow(slotRow) == true {
                println("three in a row")
                // add 1 to winnings
                winnings += 2
                // add 1 to flush count
                straightWinCount += 1
            }
         
// THREE IN A ROW
            // if checkThreeOfAKind returns true...
            if checkThreeOfAKind(slotRow) == true {
                println("Three of a kind")
                // add 1 to winnings
                winnings += 2
                // add 1 to flush count
                threeOfAKindWinCount += 1
            }
        }

// SUPER WINNERS

// ALL THREE ROWS ARE 1 COLOR
        // if fushWinCount is 3.. that means that all cards on all rows are of the same color
        if flushWinCount == 3 {
            println("Royal Flush")
            
            // add 15 to winnings for a super payout
            winnings += 15
        }
        
// ALL THREE ROWS HAVE THREE IN A ROW
        
        if straightWinCount == 3 {
            println("Epic Straight!")
            winnings += 1000
        }
        
        if threeOfAKindWinCount == 3 {
            println("Threes all around")
            winnings += 500
        }
        
        return winnings
    }
  
    
// CHECK FOR FLUSH
    class func checkFlush (slotRow: [Slot]) -> Bool {
     
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        // if all of the slots in the row are all red.. return true
        if slot1.isRed == true && slot2.isRed == true && slot3.isRed == true {
            return true
        }
        // if all of the slots in the row are not red.. return true
        else if slot1.isRed == false && slot2.isRed == false && slot3.isRed == false {
            return true
        }
        else {
            // else they are not the same color so return false
            return false
        }
    }
    

// CHECK FOR 3 IN A ROW
    class func checkThreeInARow (slotRow: [Slot]) -> Bool {
        
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        // checking to see of the three slots in the row are numerically in order going down
        // ie: slot1 is 10, slot2 is 9, slot3 is 8. This is being determined by taking the slot1 value and subtracting 1 to slot2 and subtracting 2 to slot3
        if slot1.value == slot2.value - 1 && slot1.value == slot3.value - 2 {
            return true
        }
        // checking to see of the three slots in the row are numerically in order going up
        // ie: slot1 is 8, slot2 is 9, slot3 is 10. This is being determined by taking the slot1 value and adding 1 to slot2 and adding 2 to slot3
        else if slot1.value == slot2.value + 1 && slot1.value == slot3.value + 2 {
            return true
        }
        
        else {
            
            return false
        }
    }
    
// CHECK FOR 3 IN A ROW
    class func checkThreeOfAKind (slotRow: [Slot]) -> Bool {
        
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        if slot1.value == slot2.value && slot1.value == slot3.value {
            return true
        }
        else {
            
            return false
        }

        
        
        
    
    }
    
    
    
    
    
    
}


