//
//  Factory.swift
//  SlotMachine
//
//  Created by lapacino on 7/29/15.
//  Copyright (c) 2015 lapacino. All rights reserved.
//

import Foundation
import UIKit

class Factory {
    
    class func slotMachine() -> [[Slot]] {
        
        let kContainerNumber = 3
        let kSlotNumber = 3
        var slots:[[Slot]] = []
        
        for var containerNumber = 0; containerNumber < kContainerNumber; containerNumber++ {
            
            var slotArray:[Slot] = []
            var slot:Slot
            
            for var slotNumber = 0; slotNumber < kSlotNumber; slotNumber++ {
                
                let randomNumber = Int(arc4random_uniform(UInt32(13)))
                
                slot = Factory.produceTheSlot(slotArray)
                slotArray.append(slot)

            }
            slots.append(slotArray)
        }
        return slots

    }
    
    class func produceTheSlot(cardsValue: [Slot]) -> Slot {
        
        var currentCardValue:[Int] = []
        
        for slot in cardsValue {
            currentCardValue.append(slot.value)
        }
        
    
        var randomNumber = Int(arc4random_uniform(UInt32(13)))

        while contains(currentCardValue, randomNumber) {
            if randomNumber == randomNumber {
                
                randomNumber = Int(arc4random_uniform(UInt32(13)))
            }
        }
        
        var slot:Slot
        
        switch randomNumber{
            
            
        case 0:
            slot = Slot(value: 1, image: UIImage(named: "Ace"), isRed: true)
        case 1:
            slot = Slot(value: 2, image: UIImage(named: "Two"), isRed: true)
        case 2:
            slot = Slot(value: 3, image: UIImage(named: "Three"), isRed: true)
        case 3:
            slot = Slot(value: 4, image: UIImage(named: "Four"), isRed: true)
        case 4:
            slot = Slot(value: 5, image: UIImage(named: "Five"), isRed: false)
        case 5:
            slot = Slot(value: 6, image: UIImage(named: "Six"), isRed: false)
        case 6:
            slot = Slot(value: 7, image: UIImage(named: "Seven"), isRed: true)
        case 7:
            slot = Slot(value: 8, image: UIImage(named: "Eight"), isRed: false)
        case 8:
            slot = Slot(value: 9, image: UIImage(named: "Nine"), isRed: false)
        case 9:
            slot = Slot(value: 10, image: UIImage(named: "Ten"), isRed: true)
        case 10:
            slot = Slot(value: 11, image: UIImage(named: "Jack"), isRed: false)
        case 11:
            slot = Slot(value: 12, image: UIImage(named: "Queen"), isRed: false)
        case 12:
            slot = Slot(value: 13, image: UIImage(named: "King"), isRed: true)
        default:
            slot = Slot(value: 0, image: UIImage(named: "Ace"), isRed: true)
            
        }
        
    return slot
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}