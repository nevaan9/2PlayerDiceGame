//
//  Player.swift
//  2PlayerDice
//
//  Created by Nevaan Perera on 11/26/17.
//  Copyright © 2017 Nevaan Perera. All rights reserved.
//

import Foundation

class Player {
    var isCurrentPlayer: Bool
    var roundScore: Int
    var overallScore: Int
    
    // Initialize a player object
    init() {
        isCurrentPlayer = false
        roundScore = 0
        overallScore = 0
    }
}
