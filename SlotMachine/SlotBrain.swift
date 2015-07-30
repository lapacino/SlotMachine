//
//  SlotBrain.swift
//  SlotMachine
//
//  Created by lapacino on 7/29/15.
//  Copyright (c) 2015 lapacino. All rights reserved.
//

import Foundation

class SlotBrain {
    
    class func unpackSlotInSlotRow(slots:[[Slot]]) -> [[Slot]] {
        
        var slotRow1:[Slot] = []
        var slotRow2:[Slot] = []
        var slotRow3:[Slot] = []
        
        for slotArray in slots {
            for var index = 0 ; index < slotArray.count; index++ {
                let slot = slotArray[index]
                if index == 0 {
                    
                    slotRow1.append(slot)
                }
                else if index == 1 {
                    slotRow2.append(slot)
                }
                else if index == 2 {
                    slotRow3.append(slot)
                }
                else {
                    println("error")
                }
            }
        }
    
        var slotRows = [slotRow1,slotRow2, slotRow3]
        return slotRows

    }
    
    
    class func computeWinnings(slots: [[Slot]]) -> Int {
        
        var slotInRows = unpackSlotInSlotRow(slots)
        
        var winnings = 0
        
        var flushCount = 0
        var threeOfAKind = 0
        var Straight = 0
        
        for slotRow in slotInRows {
            
            if checkFlush(slotRow) == true {
                println("Flush")
                flushCount += 1
                winnings += 1
            }
            
            if checkThreeOfAkind(slotRow) == true {
                println("ThreeOfAKind")
                threeOfAKind += 1
                winnings += 1
            }
            
            if checkStraight(slotRow) == true {
                println("Straight")
                Straight += 1
                winnings += 1
            }
            
            if flushCount == 3 {
                println("3 flush Count")
                flushCount = 0
                winnings += 10
            }
            
            if threeOfAKind == 3 {
                println("3 three of a kind")
                threeOfAKind = 0
                threeOfAKind += 15
            }
            
            if Straight == 3 {
                println("3 of straight")
                Straight = 0
                winnings += 30
            }
            
            
        }
        return winnings
    }
    
   class func checkFlush(slotRow:[Slot]) -> Bool {
        
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        if slot1.isRed == true && slot2.isRed == true && slot3.isRed == true {
            return true
        }
        else if slot1.isRed == false && slot2.isRed == false && slot3.isRed == false {
            return true
        }
        else {
            return false
        }
        
    }
    
   class func checkThreeOfAkind(slotRow: [Slot]) -> Bool {
        
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
    
    class func checkStraight(slotRow: [Slot]) -> Bool {
        
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        if slot1.value + 1 == slot2.value  && slot1.value + 2 == slot3.value {
            
            return true
        }
        else if slot1.value - 1 == slot2.value  && slot1.value - 2 == slot3.value {
            return true
        }
        else {
            return false
        }
        
    }
    
    
}