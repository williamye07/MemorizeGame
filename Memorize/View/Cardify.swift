//
//  Cardify.swift
//  Memorize
//
//  Created by William Ye on 2021-04-11.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    var rotation: Double
    
    var isFaceUp : Bool {
        rotation < 90
    }
    init(isFaceUp: Bool){
        rotation = isFaceUp ? 0 : 180
    }
    
    var animatableData: Double {
        get { return rotation}
        set {rotation = newValue}
    }
    func body(content: Content) -> some View{
        
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
                RoundedRectangle(cornerRadius: 10.0).stroke(lineWidth: 3)
                content
            }
                .opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: 10.0).fill()
                .opacity(isFaceUp ? 0 : 1)
            
        }
        .rotation3DEffect(
            Angle.degrees(rotation),
            axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/
            )
        
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}

