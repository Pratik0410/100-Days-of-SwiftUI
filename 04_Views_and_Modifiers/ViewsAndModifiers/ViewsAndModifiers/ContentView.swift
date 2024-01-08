//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Prathamesh Sonawane on 08/01/24.
//

import SwiftUI

struct CapsuleText: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(.white)
            .clipShape(.capsule)
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.black)
            .padding()
            .background(.white)
            .clipShape(.rect(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct ContentView: View {
    
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")
    
    @ViewBuilder var spells: some View {
        Text("Lumos")
        Text("Obliviate")
    }
    
    var body: some View {
        VStack {
            Text("Hello, world!").titleStyle()
            
            Button("Hello") {
                print(type(of: self.body))
            }
            .frame(width: 200, height: 50)
            .background(.white)
            .clipShape(.rect(cornerRadius: 20))
            
            VStack {
                Text("Gryffindor")
                    .font(.largeTitle)
                Text("Hufflepuff")
            }
            .foregroundColor(.white)
            .font(.title)
        
            motto1.font(.title).foregroundStyle(.white)
            motto2.font(.title).foregroundStyle(.white)
            
            spells.font(.title).foregroundColor(.white)
            
            Text("First")
                .font(.largeTitle)
                .padding()
                .foregroundStyle(.blue)
                .background(.white)
                .clipShape(.capsule)

            CapsuleText(text: "Second")
                .foregroundStyle(.yellow)
            
            Color.blue
                .frame(width: 300, height: 200)
                .watermarked(with: "Hacking with Swift")
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [.cyan, .black, .cyan], startPoint: .top, endPoint: .bottom))
    }
}

#Preview {
    ContentView()
}
