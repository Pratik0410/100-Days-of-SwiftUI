//
//  ContentView.swift
//  Animations
//
//  Created by Prathamesh Sonawane on 17/01/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationAmount = 0.0
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Button("OK") {
                animationAmount += 1
            }
            .padding(30)
            .background(.black)
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 10))
            .overlay(
                Circle()
                    .stroke(.blue)
                    .scaleEffect(animationAmount)
                    .opacity(2 - animationAmount)
                    .animation(.easeInOut(duration: 1).repeatForever(autoreverses : false), value: animationAmount)
            )
            .onAppear {
                animationAmount = 2
            }
            
            Spacer()
            
            Button("Tap Me") {
                withAnimation(.bouncy(duration: 1, extraBounce: 0.4)) {
                    animationAmount += 360
                }
            }
            .padding(30)
            .background(.black)
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 10))
            .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
