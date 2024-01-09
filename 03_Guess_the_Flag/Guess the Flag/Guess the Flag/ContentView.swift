//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Prathamesh Sonawane on 05/01/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var gameOver = false
    @State private var scoreTitle = "Game Over"
    @State private var scoreMessage = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var numberOfQuestions = 1
    
    struct FlagImage: View {
        var flag: String
        var body: some View {
            Image(flag)
                .background(.white)
                .clipShape(.capsule)
                .shadow(radius: 5)
        }
        
    }
    
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
                            FlagImage(flag: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .padding(.horizontal, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
            
                Spacer()
                
                Text("Score : \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding(20)
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestions)
        } message: {
            Text("\(scoreMessage)")
        }
        .alert("Game Over" , isPresented: $gameOver) {
            Button("Restart", action: reset)
        } message: {
            Text("You Win! Score : \(score)")
        }
        
    }
    
    func flagTapped(_ number : Int) {
        if numberOfQuestions == 8 {
            gameOver = true
        } 
        else {
            showingScore = true
        }
        
        numberOfQuestions = numberOfQuestions + 1
        
        if number == correctAnswer {
            scoreTitle = "Correct!"
            score = score + 1
            scoreMessage = "Your score is \(score)"
        }
        else {
            scoreTitle = "Wrong!"
            scoreMessage = "That's the flag of \(countries[number])!"
        }
    }
    
    func askQuestions() {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        score = 0
        numberOfQuestions = 1
        askQuestions()
    }
}

#Preview {
    ContentView()
}
