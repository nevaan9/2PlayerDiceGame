//
//  Dice.swift
//  2PlayerDice
//
//  Created by Nevaan Perera on 11/26/17.
//  Copyright © 2017 Nevaan Perera. All rights reserved.
//

import Foundation

class Dice {
    var diceArray = [String]()
    var currentRoll = 0
    
    init() {
        for suffix in 1...6{
            diceArray.append("dice-\(suffix)")
        }
    }
    
    func roll() -> String {
        currentRoll = Int(arc4random_uniform(6)) + 1
        return diceArray[currentRoll - 1]
    }
}
