//
//  editSheetView.swift
//  Memorize
//
//  Created by William Ye on 2021-04-30.
//

import SwiftUI

struct editSheetView: View {
    
    @EnvironmentObject var themeStore: ThemeStore
    
    @State private var themeName = ""
    @State private var editEmojis = ""
    @State private var stepperValue = 0
    
    @Binding var isEdit: Bool
    
    @Binding var theme :  Int
    
    var body: some View {
        VStack{
            HStack {
                Button("Cancel"){
                    isEdit = false
                }
                .padding()
                Spacer()
                Text("Edit Emoji Themes").font(.headline).padding()
                Spacer()
                Button(action: {
                    isEdit = false
                    themeStore.updateTheme(themeInd: theme, themeName: themeName, emojis: Array(editEmojis).map{String($0)}, numPairs: stepperValue)
                }, label: {
                    Text("Done")
                })
                .padding()
            }
            Form {
                Section(header: Text("Change theme name")) {
                    TextField("\(themeStore.emojiThemes[theme].themeName)", text: $themeName)
                }
                
                Section(header: Text("Edit emojis")){
                    TextField("Emojis", text: $editEmojis)
                        .onChange(of: editEmojis){ removeEmojis in
                            if removeEmojis.count < stepperValue{
                                stepperValue = removeEmojis.count
                            }
                        }
                }
                
                Section(header: Text("Change number of pairs of cards")){
                    Stepper("number of pairs: \(stepperValue)", value: $stepperValue, in: 0...editEmojis.count)
                }
                .onAppear{
                    themeName = themeStore.emojiThemes[theme].themeName
                    stepperValue = themeStore.emojiThemes[theme].numCardsShown
                    editEmojis = themeStore.emojiThemes[theme].emojiSet.joined(separator: "")
                }
            }
        }
        
        
    }
}

