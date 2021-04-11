//
//  MemorizeApp.swift
//  Memorize
//
//  Created by William Ye on 2021-04-01.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        WindowGroup {
            let game = EmojiMemoryGame()
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
