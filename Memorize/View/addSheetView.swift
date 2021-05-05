//
//  addSheetView.swift
//  Memorize
//
//  Created by William Ye on 2021-04-29.
//

import SwiftUI

struct addSheetView: View {
    
    @EnvironmentObject var themeStore: ThemeStore
    
    @State private var themeName = ""
    @State private var emojis = ""
    @State private var stepperValue = 0
    
    @Binding var isAdd: Bool
    var body: some View {
        VStack{
            HStack {
                Text("Add Emoji Themes").font(.headline).padding()
                Spacer()
                Button(action: {
                    isAdd = false
                    let arr = Array(emojis).map{String($0)}
                    themeStore.addTheme(themeName: themeName, emojis: arr, numPairs: stepperValue)
                }, label: {
                    Text("Done")
                })
                .padding()
            }
            Form {
                Section(header: Text("Add a theme name")) {
                    TextField("Theme Name", text: $themeName)
                }
                
                Section(header: Text("Add emojis")){
                    TextField("Emojis", text: $emojis)
                }
                
                Section(header: Text("Number of pairs of cards")){
                    Stepper("number of pairs: \(stepperValue)", value: $stepperValue, in: 0...emojis.count)
                }
            }
        }
        
        
    }
}

