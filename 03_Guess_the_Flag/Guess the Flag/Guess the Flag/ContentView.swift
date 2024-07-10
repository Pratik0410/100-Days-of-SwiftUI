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
    @State private var animationAmount = 0.0
    @State private var opacityAmount = 1.0
    @State private var selectedFlag : Int?
    @State private var flagAnimationAmount = 1.0
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold.",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
        "Poland": "Flag with two horizontal stripes. Top stripe white, bottom stripe red.",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red.",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
        "Ukraine": "Flag with two horizontal stripes. Top stripe blue, bottom stripe yellow.",
        "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner."
    ]
    
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
                        .rotation3DEffect(
                            .degrees(selectedFlag == number ? animationAmount : 0),
                                                  axis: (x: 0.0, y: 1.0, z: 0.0)
                        )
                        .opacity(selectedFlag == number ? 1 : opacityAmount)
                        .scaleEffect(selectedFlag == number ? 1 : flagAnimationAmount)
                        .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
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
        
        selectedFlag = number
        
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
            withAnimation {
                animationAmount += 360
                opacityAmount *= 0.25
                flagAnimationAmount -= 0.25
            }
        }
        else {
            scoreTitle = "Wrong!"
            scoreMessage = "That's the flag of \(countries[number])!"
            withAnimation {
                animationAmount -= 360
                opacityAmount *= 0.25
                flagAnimationAmount -= 0.25
            }
        }
    }
    
    func askQuestions() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        withAnimation {
            animationAmount = 0.0
            opacityAmount = 1.0
            flagAnimationAmount = 1.0
        }
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
