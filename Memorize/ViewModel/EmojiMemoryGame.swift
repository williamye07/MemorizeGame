//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by William Ye on 2021-04-05.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    var gameTheme : Theme
    
    var gameThemeJson : Data?
    
    @Published private var model: MemoryGame<String>
    
    init(_ theme: Theme){
        let gameTheme = theme
        self.gameTheme = gameTheme
        model = EmojiMemoryGame.createMemoryGame(gameTheme)
        gameThemeJson = try? JSONEncoder().encode(gameTheme)
        if gameThemeJson != nil{
            print("Selected gameTheme: \(gameThemeJson!.utf8!)")
        }
    }
    
    private static func createMemoryGame(_ gameTheme: Theme) -> MemoryGame<String> {
        let emojis = gameTheme.emojiSet
        let numCards = gameTheme.numCardsShown
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
        gameThemeJson = try? JSONEncoder().encode(gameTheme)
        if gameThemeJson != nil{
            print("Selected gameTheme: \(gameThemeJson!.utf8!)")
        }

        model = EmojiMemoryGame.createMemoryGame(gameTheme)
    }
}
