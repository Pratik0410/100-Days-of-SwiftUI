//
//  ContentView.swift
//  Animations
//
//  Created by Prathamesh Sonawane on 17/01/24.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    
    var body: some View {
        
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 100)
                .clipShape(.rect(cornerRadius: 20))
            
            if enabled {
                Rectangle()
                    .fill(.black)
                    .frame(width: 200, height: 100)
                    .clipShape(.rect(cornerRadius: 20))
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                enabled.toggle()
            }
        }
    }
}

#Preview {
    ContentView()
}
