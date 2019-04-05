//
//  Card.swift
//  Memory
//
//  Created by Maxim Vitovitsky on 29/03/2019.
//  Copyright © 2019 Максим Витовицкий. All rights reserved.
//

import Foundation

struct Card {
    
    var isMatched = false
    var isFaceUp = false
    var id: Int
    
    static var lastIdentifier = -1
    
    static func getUniqueIdentifier() -> Int {
        lastIdentifier += 1
        return lastIdentifier
    }
    
    init() {
        self.id = Card.getUniqueIdentifier()
    }
    
    func testFunc() {
        
    }
    
}
