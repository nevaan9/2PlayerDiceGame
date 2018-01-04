//
//  ViewController.swift
//  2PlayerDice
//
//  Created by Nevaan Perera on 11/26/17.
//  Copyright © 2017 Nevaan Perera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Win Screen
    @IBOutlet weak var winScreen: UIView!
    @IBOutlet weak var winLabel: UILabel!
    
    //score limit
    var scoreLimit = 50
    
    //
    @IBOutlet var buttons: [UIButton]!
    
    // Current player UIView Array
    @IBOutlet var currentPlayerView: [UIView]!
    
    // Current score array
    @IBOutlet var currentScore: [UILabel]!
    
    //overall score array
    @IBOutlet var overallScore: [UILabel]!
    
    // Dice Image
    @IBOutlet weak var diceImage: UIImageView!
    
    // Initialize objects
    let dice = Dice()
    lazy var game = Game(currentPlayerView.count)
    
    // Open the app
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initializeGame()
        print(currentScore.count)
        print(overallScore.count)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Hold Button
    @IBAction func holdBtn(_ sender: UIButton) {
        game.currentPlayer.overallScore += game.currentPlayer.roundScore
        changePlayer()
    }
    
    // Roll Button
    @IBAction func rollBtn(_ sender: UIButton) {
        diceChange()
        
        if dice.currentRoll != 1{
            game.currentPlayer.roundScore += dice.currentRoll
            currentScore[game.currentPlayerIndex].text = "\(game.currentPlayer.roundScore)"
        }
        else{
            changePlayer()
        }

    }
    
    // Roll the dice
    func diceChange(){
        diceImage.image = UIImage(named: dice.roll())
    }
    
    // Start of a new game
    func initializeGame(){
        
//        let alertController = UIAlertController(title: "Enter the score limit", message: "I'll be surprised if you go anything over 300", preferredStyle: .alert)
//
//        alertController.addTextField(configurationHandler: {(_ textField: UITextField) -> Void in
//            textField.placeholder = "Score limit"
//        })
//
//        let confirmAction = UIAlertAction(title: "OK", style: .default, handler: {(_ action: UIAlertAction) -> Void in
//            print("Current password \(String(describing: alertController.textFields?[0].text))")
//            //compare the current password and do action here
//        })
//
//        alertController.addAction(confirmAction)
//
//        present(alertController, animated: true, completion: nil)
        
        // ---------------------------------------------------------------------------------------
        for btn in buttons{
            btn.isEnabled = true
            btn.setTitleColor(#colorLiteral(red: 1, green: 0, blue: 0.1495437769, alpha: 0.8286806778), for: UIControlState.normal)
        }
        winScreen.isHidden = true;
        diceChange()
        for player in game.playerArray{
            player.overallScore = 0
            player.roundScore = 0
        }
        changePlayer()
        updateUI()
    }
    
    // change player
    func changePlayer(){
        // Make all the players current scores 0
        game.currentPlayer.roundScore = 0
        updateUI()
        game.shiftCurrentPlayer()
        for index in game.playerArray.indices{
            if game.playerArray[index].isCurrentPlayer{
                currentPlayerView[index].backgroundColor = #colorLiteral(red: 0.9355931878, green: 0.9288527369, blue: 1, alpha: 1)
            }
            else{
                currentPlayerView[index].backgroundColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
            }
        }
    }
    
    // Update UI
    func updateUI(){
        // Check if the game is over
        if game.currentPlayer.overallScore > scoreLimit{
            currentScore[game.currentPlayerIndex].text = "\(game.currentPlayer.roundScore)"
            
            overallScore[game.currentPlayerIndex].text = "Win!"
            disableGame()
        }
        else{
            currentScore[game.currentPlayerIndex].text = "\(game.currentPlayer.roundScore)"
            overallScore[game.currentPlayerIndex].text = "\(game.currentPlayer.overallScore)"
        }
    }
    
    func disableGame(){
        for btn in buttons{
            btn.isEnabled = false
            btn.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: UIControlState.normal)
        }
        for index in game.playerArray.indices{
            currentScore[index].text = "\(game.playerArray[index].overallScore)"
        }
        winLabel.text = "Player \(game.currentPlayerIndex + 1) wins!"
        winScreen.isHidden = false;
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        initializeGame()
    }
}

