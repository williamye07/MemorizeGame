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
                    withAnimation(.linear(duration: 0.6)) {
                        viewModel.choose(card: card)
                    }
                    
                }
                .padding()
            }
            
            Text("Score: \(viewModel.score)")
                .font(.headline)
                .padding()
        }

        .foregroundColor(Color(viewModel.gameTheme.themeColor) )
        .padding()

    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation(){
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)){
            animatedBonusRemaining = 0
        }
    }
    var body: some View{
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack{
                    Group {
                        if card.isConsumingBonusTime {
                            TimePie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90))
                                .onAppear{
                                    startBonusTimeAnimation()
                                }
                        } else {
                            TimePie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90))
                        }
                    }.padding(5).opacity(0.4)
                    
                    Text(card.content)
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
                        
                }
                .cardify(isFaceUp: card.isFaceUp)
                .font(Font.system(size: min(geometry.size.width, geometry.size.height) * 0.7))
            }
        }
    }
}









struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame(Themes[0])
        EmojiMemoryGameView(viewModel: game)
            .previewDevice("iPhone SE (2nd generation)")
    }
}
