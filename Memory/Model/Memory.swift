//
//  Memory.swift
//  Memory
//
//  Created by Maxim Vitovitsky on 29/03/2019.
//  Copyright © 2019 Максим Витовицкий. All rights reserved.
//

import Foundation

class Memory {
    
    var cards = [Card]()
    var chosenCards = [Int]()
    var indexOfFaceUpCard: Int?
    var counter = 0
    func chooseCard(at index: Int) {
        
        chosenCards.append(index)
        cards[index].isFaceUp = true
        print(index,"index")
   }
    
    
    func checkYourChoose() -> Bool {
        if cards[chosenCards[0]].id == cards[chosenCards[1]].id {
            return true
        }
        else {
            return false
        }
    }
    
    init(numberOfCardPairs: Int) {
        for _ in 1...numberOfCardPairs {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
}
