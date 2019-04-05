//
//  ViewController.swift
//  Memory
//
//  Created by Maxim Vitovitsky on 29/03/2019.
//  Copyright © 2019 Максим Витовицкий. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var winAlert: UIAlertController!
    var yes: UIAlertAction!
    
    var game: Memory!
    
    var emojiList: [String]!

    var emoji: [Int:String]!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    
    @IBOutlet weak var restartButton: UIButton! {
        didSet {
            restartButton.layer.cornerRadius = restartButton.frame.size.height / 2
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: Any) {
        newGame()
    }
    
    @IBAction func cardButtonAction(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardIndex)
            updateButtons()
        } else {
            print("This button is not in card buttons!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGame()
        
        winAlert = UIAlertController(title: "You won!", message: "Do you want to restart?", preferredStyle: .alert)
        yes = UIAlertAction(title: "Yes", style: .default) { _ in self.newGame() }
        
        winAlert.addAction(yes)
    }
    
    
    
    
    func updateButtons() {
        
        if game.chosenCards.count == 1 {
            let firstIndex = game.chosenCards[0]
            cardFaceUp(button: cardButtons[firstIndex], indexAtCardsArray: firstIndex)
            cardButtons[firstIndex].isEnabled = false
        }
        else  {
            let secondIndex = game.chosenCards[1]
            let firstIndex = game.chosenCards[0]
            let firstButton = cardButtons[firstIndex]
            let secondButton = cardButtons[secondIndex]
            cardFaceUp(button: secondButton, indexAtCardsArray: secondIndex)
            if  game.checkYourChoose() {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                    self.setupIfTruePair(firstButton: firstButton, secondButton: secondButton)
                }
            }
            else {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)  ) {
                    self.setupIfWrongPair(firstButton: firstButton, secondButton:  secondButton)
                }
            }
            cardButtons[firstIndex].isEnabled = true
            game.chosenCards.removeAll()
            if checkIfGameIsOver() {
                present(winAlert, animated: true)
            }
        }
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.id] == nil, emojiList.count > 0 {
            let randomIndex = Int.random(in: 0..<emojiList.count)
            emoji[card.id] = emojiList.remove(at: randomIndex)
        }
        return emoji[card.id] ?? "?"
    }
    
    func cardFaceUp(button : UIButton, indexAtCardsArray: Int) {
        button.setTitle(emoji(for: game.cards[indexAtCardsArray]), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    func setupIfWrongPair(firstButton: UIButton,secondButton: UIButton) {
        firstButton.backgroundColor = #colorLiteral(red: 0.2723996043, green: 0.6819463372, blue: 0.632582128, alpha: 1)
        firstButton.setTitle("", for: .normal)
        secondButton.backgroundColor = #colorLiteral(red: 0.2723996043, green: 0.6819463372, blue: 0.632582128, alpha: 1)
        secondButton.setTitle("", for: .normal)
    }
    
    func setupIfTruePair(firstButton: UIButton,secondButton: UIButton) {
        firstButton.backgroundColor = .white
        firstButton.setTitle("", for: .normal)
        firstButton.isEnabled = false
        secondButton.backgroundColor = .white
        secondButton.setTitle("", for: .normal)
        secondButton.isEnabled = false
    }
    func checkIfGameIsOver() -> Bool {
        var counter = 0
        for index in cardButtons.indices {
            if cardButtons[index].backgroundColor == .white {
                counter += 1
            }
        }
        if counter+2 == cardButtons.count {
            return true
        }
        else {
            print(counter)
            return false
        }
    }
    
    func newGame() {
        game = Memory(numberOfCardPairs: (cardButtons.count + 1) / 2)
        game.chosenCards.removeAll()
        for index in cardButtons.indices {
            cardButtons[index].isEnabled = true
            cardButtons[index].isHidden = false
            cardButtons[index].backgroundColor = #colorLiteral(red: 0.2723996043, green: 0.6819463372, blue: 0.632582128, alpha: 1)
            cardButtons[index].setTitle("", for: .normal)
            emojiList = ["🦊", "🐻", "🐼", "🐨", "🦁", "🐯", "🐵", "🦉", "🦇"]
            emoji = [Int:String]()
            
        }
        
    }
    
    
}


