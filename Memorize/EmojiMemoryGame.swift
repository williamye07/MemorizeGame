//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by William Ye on 2021-04-05.
//

import SwiftUI

func createCardContent(pairIndex: Int) -> String {
    return "😀"
}

class EmojiMemoryGame {
    private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    static func createMemoryGame() -> MemoryGame<String> {
        let emojis = ["👻", "🎃", "😎", "😱", "🍆"]
        let numCards = Int.random(in: 2...4)
        return MemoryGame<String>(numberOfPairsOfCards: numCards) { pairIndex in
            return emojis[pairIndex]
        }
    }
        
    
    var cards: Array<MemoryGame<String>.Card>{
        model.cards
    }
    
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
}
