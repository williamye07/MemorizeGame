//
//  MemoryGame.swift
//  Memorize
//
//  Created by William Ye on 2021-04-05.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    var cards: Array<Card>
    
    var score = 0
    
    var indexOnlyFaceUp: Int? {
        get{
            let faceUpCardIndices = cards.indices.filter{i in cards[i].isFaceUp}
            return faceUpCardIndices.count == 1 ? faceUpCardIndices[0] : nil
        }
        set {
            for i in cards.indices {
                cards[i].isFaceUp = i == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        if let chosenIndex = cards.index(of: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched{
            if let targetIndex = indexOnlyFaceUp {
                if cards[chosenIndex].content == cards[targetIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[targetIndex].isMatched = true
                    score += 2
                } else if cards[chosenIndex].seen {
                    score -= 1
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOnlyFaceUp = chosenIndex
            }
            cards[chosenIndex].seen = true

        }
    }
    
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = cardContentFactory(pairIndex)
            cards.append(Card(isMatched: false, content: content, id: pairIndex * 2))
            cards.append(Card(isMatched: false, content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched: Bool
        var seen = false
        var content: CardContent
        var id: Int
    }
}
