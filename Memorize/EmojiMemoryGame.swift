//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by William Ye on 2021-04-05.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    var gameTheme : Theme
    
    @Published private var model: MemoryGame<String>
    
    init(){
        let gameTheme = Themes[Int.random(in: 0..<Themes.count)]
        self.gameTheme = gameTheme
        model = EmojiMemoryGame.createMemoryGame(gameTheme)
    }
    
    static func createMemoryGame(_ gameTheme: Theme) -> MemoryGame<String> {
        let emojis = gameTheme.emojiSet
        let numCards = gameTheme.numCardsShown ?? Int.random(in: 2..<emojis.count)
        return MemoryGame<String>(numberOfPairsOfCards: numCards) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    var score: Int {
        model.score
    }
    
    var cards: Array<MemoryGame<String>.Card>{
        model.cards
    }
    
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
    
    func resetGame() {
        gameTheme = Themes[Int.random(in: 0..<Themes.count)]
        model = EmojiMemoryGame.createMemoryGame(gameTheme)
    }
}
