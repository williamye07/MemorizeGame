//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by William Ye on 2021-04-01.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            HStack {
                Button("New Game"){
                    viewModel.resetGame()
                }
                .padding()
                Text("Theme: \(viewModel.gameTheme.themeName)")
                    .padding()
            }
            .font(.headline)

            Grid (viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    viewModel.choose(card: card)
                }
                .padding()
            }
            
            Text("Score: \(viewModel.score)")
                .font(.headline)
                .padding()
        }

        .foregroundColor(viewModel.gameTheme.themeColor)
        .padding()

    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View{
        GeometryReader { geometry in
            ZStack {
                if card.isFaceUp {
                    RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                    RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                    Text(card.content)
                } else {
                    if !card.isMatched {
                        RoundedRectangle(cornerRadius: 10.0).fill()
                    }
                }
            }
            .font(Font.system(size: min(geometry.size.width, geometry.size.height) * 0.75))
        }
        
        
        
        
    }
}









struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(viewModel: game)
            .previewDevice("iPhone SE (2nd generation)")
    }
}
