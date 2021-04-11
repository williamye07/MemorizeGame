//
//  Themes.swift
//  Memorize
//
//  Created by William Ye on 2021-04-10.
//

import SwiftUI

struct Theme {
    let themeName: String
    let emojiSet: [String]
    let numCardsShown : Int?
    let themeColor: Color
}

let Themes = [
    Theme(themeName: "halloween", emojiSet: ["👻", "🎃", "💀", "🧟‍♀️", "🧛🏿"], numCardsShown: 5, themeColor: .orange),
    Theme(themeName: "food", emojiSet: ["🧋", "🍩", "🌮", "🍔", "🍕", "🍗", "🥞"], numCardsShown: 7, themeColor: .purple),
    Theme(themeName: "faces", emojiSet: ["😀", "😂", "🤪", "😛", "😎", "🥺", "😡", "🤠"], numCardsShown: 8, themeColor: .yellow),
    Theme(themeName: "countries", emojiSet: ["🇨🇦", "🇨🇳", "🇺🇸", "🇦🇹", "🇸🇦", "🇰🇷", "🇬🇧", "🇵🇹", "🇯🇵", "🇧🇷"], numCardsShown: 10, themeColor: .blue),
    Theme(themeName: "sports", emojiSet: ["⚽️", "🏀", "🏈", "⚾️", "🎾"], numCardsShown: 5, themeColor: .green),
    Theme(themeName: "symbols", emojiSet: ["❤️", "💯", "⁉️", "🔞", "🆘", "❌", "🚭", "🛑", "🅾️", "🈲"], numCardsShown: 5, themeColor: .red),]
