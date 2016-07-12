//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    @IBAction func redButtonTapped(sender: AnyObject) {
        simonSaysGame.guessRed()
        print("red tapped")
        buttonsClicked += 1
        checkWin()
    }
    
    @IBAction func greenButtonTapped(sender: AnyObject) {
        simonSaysGame.guessGreen()
        print("green tapped")
        buttonsClicked += 1
        checkWin()
    }
    
    @IBAction func yellowButtonTapped(sender: AnyObject) {
        simonSaysGame.guessYellow()
        print("yellow tapped")
        buttonsClicked += 1
        checkWin()
    }
    
    @IBAction func blueButtonTapped(sender: AnyObject) {
        simonSaysGame.guessBlue()
        print("blue tapped")
        buttonsClicked += 1
        checkWin()
    }
    
    func checkWin(){
        if buttonsClicked == 5 && simonSaysGame.sequenceFinished() {
            simonSaysGame.wonGame()
            winLabel.hidden = false
            if simonSaysGame.wonGame(){
                winLabel.text = "You won!"
                buttonsClicked = 0 //reset buttonsClicked variable
            }
            else {
                winLabel.text = "Nope, try again."
            }
           // resetGame()
        }
    }
    
//    func resetGame(){
//        winLabel.hidden = true
//        startGameButton.hidden = false
//    }
    //when trying to implement resetGame, the winLabel dissapears before it displays the text (or does it immediately after and its so fast we can't see it) so will work on fixing that later 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        winLabel.hidden = true
    }
}

// MARK: - SimonSays Game Methods
extension ViewController {
    
    @IBAction func startGameTapped(sender: UIButton) {
        UIView.transitionWithView(startGameButton, duration: 0.9, options: .TransitionFlipFromBottom , animations: {
            self.startGameButton.hidden = true
            }, completion: nil)
        
        displayTheColors()
    }
    
    private func displayTheColors() {
        self.view.userInteractionEnabled = false
        UIView.transitionWithView(displayColorView, duration: 1.5, options: .TransitionCurlUp, animations: {
            self.displayColorView.backgroundColor = self.simonSaysGame.nextColor()?.colorToDisplay
            self.displayColorView.alpha = 0.0
            self.displayColorView.alpha = 1.0
            }, completion: { _ in
                if !self.simonSaysGame.sequenceFinished() {
                    self.displayTheColors()
                } else {
                    self.view.userInteractionEnabled = true
                    print("Pattern to match: \(self.simonSaysGame.patternToMatch)")
                }
        })
    }
}
