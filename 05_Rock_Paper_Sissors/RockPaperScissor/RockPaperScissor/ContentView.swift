//
//  ContentView.swift
//  RockPaperScissor
//
//  Created by Prathamesh Sonawane on 10/01/24.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = ["rock", "paper", "scissors"]
    @State private var moveEmojis = ["rock": "✊", "paper": "✋", "scissors": "✌️"]
    @State private var currentChoice = "rock"
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var questionNumber = 0
    @State private var gameOver = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.purple, .black, .purple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack {
                Spacer()

                Text("Try to \(shouldWin ? "win" : "lose") this time!")
                    .font(.title)
                    .foregroundStyle(.white)

                Spacer()

                HStack {
                    ForEach(moves, id: \.self) { move in
                        Button(moveEmojis[move] ?? "❓") {
                            evaluateSuccess(move: move)
                        }
                        .padding()
                        .font(.system(size: 70))
                        .background(.regularMaterial)
                        .foregroundColor(.white)
                        .clipShape(.circle)
                    }
                }

                Spacer()

                Text("Score: \(score)")
                    .font(.title)
                    .foregroundStyle(.white)

                Spacer()
            }
            .alert("Game over", isPresented: $gameOver) {
                Button("Play again", action: reset)
            } message: {
                Text("Your final score is \(score)")
            }
        }
    }

    func evaluateSuccess(move: String) {
        let solutions = [
            "rock": (win: "paper", lose: "scissors"),
            "paper": (win: "scissors", lose: "rock"),
            "scissors": (win: "rock", lose: "paper")
        ]

        guard let answer = solutions[currentChoice] else {
            fatalError("Unknown move: \(currentChoice)")
        }

        let isCorrect: Bool

        if shouldWin {
            isCorrect = move == answer.win
        } else {
            isCorrect = move == answer.lose
        }

        if isCorrect {
            score += 1
        } else {
            score -= 1
        }

        questionNumber += 1
        
        if questionNumber == 10 {
            gameOver = true
        }

        currentChoice = moves[Int.random(in: 0..<3)]
        shouldWin.toggle()
    }

    func reset() {
        questionNumber = 0
        score = 0
        currentChoice = moves[Int.random(in: 0..<3)]
        shouldWin.toggle()
    }
}

#Preview {
    ContentView()
}
