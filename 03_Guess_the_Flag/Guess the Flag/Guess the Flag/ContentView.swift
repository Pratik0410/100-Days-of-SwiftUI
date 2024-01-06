//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Prathamesh Sonawane on 05/01/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black, .blue], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                Spacer()
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.title3.weight(.semibold))
                        Text(countries[correctAnswer])
                            .font(.title.weight(.heavy))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .background(.white)
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .padding(.horizontal, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
            
                Spacer()
                
                Text("Score :")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding(20)
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestions)
        } message: {
            Text("Your score is ???")
        }
    }
    
    func flagTapped(_ number : Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
        }
        else {
            scoreTitle = "Wrong!"
        }
        
        showingScore = true
    }
    
    func askQuestions() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
