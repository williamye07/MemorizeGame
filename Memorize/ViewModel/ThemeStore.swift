//
//  ThemeStore.swift
//  Memorize
//
//  Created by William Ye on 2021-04-28.
//

import SwiftUI
import Combine

struct Theme : Codable, Identifiable {
    
    let emojiSet: [String]
    let themeName: String
    let numCardsShown : Int
    let themeColor: UIColor.RGB
    var id: UUID
}

let Themes = [
    Theme(emojiSet: ["👻", "🎃", "💀", "🧟‍♀️", "🧛🏿"], themeName: "Halloween", numCardsShown: 5, themeColor: UIColor(red: 255/255, green: 159/255, blue: 10/255, alpha: 1).rgb, id: UUID()),
    Theme( emojiSet: ["🧋", "🍩", "🌮", "🍔", "🍕", "🍗", "🥞"], themeName: "Food",numCardsShown: 7, themeColor: UIColor(red: 128/255, green: 0, blue: 128/255, alpha: 1).rgb, id: UUID()),
    Theme(emojiSet: ["😀", "😂", "🤪", "😛", "😎", "🥺", "😡", "🤠"], themeName: "Faces", numCardsShown: 8, themeColor: UIColor(red: 255/255, green: 204/255, blue: 0, alpha: 1).rgb, id: UUID()),
    Theme(emojiSet: ["🇨🇦", "🇨🇳", "🇺🇸", "🇦🇹", "🇸🇦", "🇰🇷", "🇬🇧", "🇵🇹", "🇯🇵", "🇧🇷"], themeName: "Countries", numCardsShown: 10, themeColor: UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).rgb, id: UUID()),
    Theme(emojiSet: ["⚽️", "🏀", "🏈", "⚾️", "🎾"], themeName: "Sports", numCardsShown: 5, themeColor: UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1).rgb, id: UUID()),
    Theme(emojiSet: ["❤️", "💯", "⁉️", "🔞", "🆘", "❌", "🚭", "🛑", "🅾️", "🈲"], themeName: "Symbols", numCardsShown: 5, themeColor: UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1).rgb, id: UUID())]


func convertColorToRGB(_ color: Color) -> UIColor.RGB{
    switch color {
    case .red:
        return UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1).rgb
    case .purple:
        return UIColor(red: 128/255, green: 0, blue: 128/255, alpha: 1).rgb
    case .yellow:
        return UIColor(red: 255/255, green: 204/255, blue: 0, alpha: 1).rgb
    case .green:
        return UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1).rgb
    case .blue:
        return UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).rgb
    case .orange:
        return UIColor(red: 255/255, green: 159/255, blue: 10/255, alpha: 1).rgb
    default:
        return UIColor(red: 255/255, green: 0, blue: 0, alpha: 1).rgb
    }
}

class ThemeStore: ObservableObject {
    
    @Published private var themes:[Theme]

    private var autosave: AnyCancellable?
    
    func addTheme(themeName: String, emojis: [String], numPairs: Int) {
        let tempTheme = Theme(emojiSet: emojis, themeName: themeName, numCardsShown: numPairs, themeColor: UIColor(red: 255/255, green: 59/255, blue: 48/255, alpha: 1).rgb, id: UUID())
        themes.append(tempTheme)
    }
    
    func removeTheme(_ theme: Theme) {
        let index = themes.index(of: theme)!
        themes.remove(at: index)
    }
    
    func updateTheme(themeInd: Int, themeName: String, emojis: [String], numPairs: Int){
        themes[themeInd] = Theme(emojiSet: emojis, themeName: themeName, numCardsShown: numPairs, themeColor: themes[themeInd].themeColor, id: themes[themeInd].id)
    }
    
    var emojiThemes : [Theme]{
        themes
    }
    
    init(){
        if let data = UserDefaults.standard.data(forKey: "Themes") {
            if let decodedTheme = try? JSONDecoder().decode([Theme].self, from: data){
                themes = decodedTheme
            } else {
                themes = Themes
            }
        } else {
            themes = Themes
        }
        autosave = $themes.sink { themes in
            if let data = try? JSONEncoder().encode(themes){
                UserDefaults.standard.set(data, forKey: "Themes")
            }
        }
    }
    

}
