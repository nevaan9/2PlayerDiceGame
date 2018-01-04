//
//  Game.swift
//  2PlayerDice
//
//  Created by Nevaan Perera on 11/26/17.
//  Copyright © 2017 Nevaan Perera. All rights reserved.
//

import Foundation

class Game {
    var playerArray = Array<Player>()
    var currentPlayerIndex: Int
    var currentPlayer: Player
    
    init(_ numberOfPlayers: Int) {
        for _ in 0..<numberOfPlayers{
            let player = Player()
            playerArray.append(player)
        }
        currentPlayerIndex = 1
        playerArray[currentPlayerIndex].isCurrentPlayer = true
        currentPlayer = playerArray[currentPlayerIndex]
    }
    
    func shiftCurrentPlayer(){
        for index in playerArray.indices{
            if playerArray[index].isCurrentPlayer {
                playerArray[index].isCurrentPlayer = false
                playerArray[(index+1) % playerArray.count].isCurrentPlayer = true
                currentPlayerIndex = (index+1) % playerArray.count
                currentPlayer = playerArray[currentPlayerIndex]
                break
            }
        }
        
    }
}
