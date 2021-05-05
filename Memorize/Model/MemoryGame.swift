//
//  MemoryGame.swift
//  Memorize
//
//  Created by William Ye on 2021-04-05.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    var score = 0
    
    private var indexOnlyFaceUp: Int? {
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
        
        if let chosenIndex = cards.index(of: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched{
            if let targetIndex = indexOnlyFaceUp {
                if cards[chosenIndex].content == cards[targetIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[targetIndex].isMatched = true
                    if cards[chosenIndex].hasEarnedBonus && cards[targetIndex].hasEarnedBonus {
                        score += 2 + Int(min(cards[chosenIndex].bonusTimeRemaining, cards[targetIndex].bonusTimeRemaining))
                    }
                    score += 2
                } else if cards[chosenIndex].seen {
                    score -= 1
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOnlyFaceUp = chosenIndex
            }
            cards[chosenIndex].seen = true
            print("card chosen: \(card)")
        }
    }
    
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var seen = false
        var content: CardContent
        var id: Int
        
        
         var bonusTimeLimit: TimeInterval = 6

         // how long this card has even been face up
         private var faceUpTime: TimeInterval {
             if let lastFaceUpDate = self.lastFaceUpDate {
                 return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
             } else {
                 return pastFaceUpTime
             }
         }

         // the last time this card was turned up (and is still face up)
         var lastFaceUpDate: Date?

         // the accumulated time this card has been face up in the past
         /// not incuding the current time it's been face up if it is currently so
         var pastFaceUpTime: TimeInterval = 0

         // how much time left before the bonus opportunity runs out
         var bonusTimeRemaining: TimeInterval {
             max(0, bonusTimeLimit - faceUpTime)
         }

         // % of the bonus time remaining
         var bonusRemaining: Double {
             (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
         }

         // whether the card was matched during the bonus time period
         var hasEarnedBonus: Bool {
             isMatched && bonusTimeRemaining > 0
         }

         // whether we are currently face up, unmatched and have not yet used up the bonus window
         var isConsumingBonusTime: Bool {
             isFaceUp && !isMatched && bonusTimeRemaining > 0
         }

         // called when the card transitions to face up state
         private mutating func startUsingBonusTime() {
             if isConsumingBonusTime, lastFaceUpDate == nil {
                 lastFaceUpDate = Date()
             }
         }

         // called when the card goes back face down (or gets matched)
         private mutating func stopUsingBonusTime() {
             pastFaceUpTime = faceUpTime
             lastFaceUpDate = nil
         }
    }
}
