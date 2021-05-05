//
//  ThemeSelector.swift
//  Memorize
//
//  Created by William Ye on 2021-04-28.
//

import SwiftUI

struct ThemeSelector: View {
    
    @EnvironmentObject var themeStore: ThemeStore
    @Environment(\.presentationMode) var presentation
    
    @State var isAdd = false
    
    @State private var editMode: EditMode = .inactive
    @State private var isEditing = false
    
    @State private var editTheme: Int = 1
    
    var body: some View {
        NavigationView {
            List {
                ForEach(themeStore.emojiThemes){ theme in
                    NavigationLink(destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme))){
                        HStack{
                            if editMode.isEditing {
                                Image(systemName: "square.and.pencil")
                                    .imageScale(.large)
                                    .opacity(editMode.isEditing ? 1 : 0)
                                    .onTapGesture {
                                        if editMode.isEditing {
                                            editTheme = themeStore.emojiThemes.index(of: theme)!
                                            print(" \(editTheme) \(isEditing)")
                                            isEditing = true
                                        }
                                        
                                    }
                            } else {
                                EmptyView()
                            }
                            
                            VStack(alignment: .leading){
                                Text(theme.themeName)
                                    .foregroundColor(Color(theme.themeColor))
                                    .font(.title)
                                if theme.numCardsShown == theme.emojiSet.count {
                                    Text("All of \(theme.emojiSet.joined())")
                                } else {
                                    Text("\(theme.numCardsShown) of \(theme.emojiSet.joined())")
                                }
                            }
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { themeStore.emojiThemes[$0] }.forEach { theme in
                        themeStore.removeTheme(theme)
                    }
                }
            }
            .navigationTitle("Memorize Game")
            .navigationBarItems(leading: Button(action: {
                isAdd = true
            }, label: {
                Image(systemName: "plus")
                    .imageScale(.large)
            }),
            trailing: EditButton())
            .environmentObject(themeStore)
            .environment(\.editMode, $editMode)
            .sheet(isPresented: $isAdd, content: {
                addSheetView(isAdd: $isAdd)
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .sheet(isPresented: $isEditing, content: {
            editSheetView(isEdit: $isEditing, theme: $editTheme)
        })
        
    }
}

struct ThemeSelector_Previews: PreviewProvider {
    static var previews: some View {
        ThemeSelector()
    }
}
