//
//  ContentView.swift
//  Edutainment
//
//  Created by Prathamesh Sonawane on 20/01/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentMultiplier = 2
    @State private var currentMultipliable = Int.random(in: 0...10)
    @State private var answer : Int? = nil
    @State private var selectedQuestion = 5
    @State private var numberOfQuestions = [5, 10, 20]
    @State private var selectedDifficultyLevel = "Beginner"
    @State private var difficultyLevels = ["Beginner", "Intermediate", "Expert"]
    @State private var score = 0
    @State private var questionsAsked = 0
    @State private var questionVisible = false
    @State private var submitAnswer = false
    @State private var alertTitle = "Missing Something!"
    @State private var alertMessage = "Share your answer and climb the learning ladder"
    @State private var restartMessage = ""
    
    @FocusState private var inputFieldIsFocused: Bool
    
    var body: some View {
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [
                        Color(red: 0.655, green: 0.992, blue: 0.467), // Lime Green
                        Color(red: 0.255, green: 0.953, blue: 0.851), // Turquoise
                        Color(red: 0.000, green: 0.965, blue: 0.965), // Aqua
                        Color(red: 0.498, green: 0.957, blue: 0.996)  // Light Blue
                    ]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                Text("Edutainment")
                    .font(.largeTitle)
                    .bold()
                    .italic()
                    .fontDesign(.serif)
                
                Spacer()
                
                if !questionVisible {
                    Section("Choose your multiplication adventure!") {
                        Stepper("\(currentMultiplier)", value: $currentMultiplier, in: 2...12)
                            .fontDesign(.monospaced)
                    }
                    .foregroundStyle(.black)
                    .fontDesign(.monospaced)
                    .multilineTextAlignment(.center)
                    
                    Section("Choose your math marathon distance!") {
                        Picker("Marathon Distance", selection: $selectedQuestion) {
                            ForEach(numberOfQuestions, id: \.self) {
                                Text($0, format: .number)
                                    .fontDesign(.monospaced)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    .foregroundStyle(.black)
                    .fontDesign(.monospaced)
                    
                    Section("Choose your adventure's\ndifficulty") {
                        Picker("Marathon Distance", selection: $selectedDifficultyLevel) {
                            ForEach(difficultyLevels, id: \.self) {
                                Text($0)
                                    .fontDesign(.monospaced)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    .foregroundStyle(.black)
                    .fontDesign(.monospaced)
                    .multilineTextAlignment(.center)
                    
                    Button("Tap to play!") {
                        questionVisible = true
                    }
                    .padding(20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 10))
                    .foregroundStyle(.black)
                    .fontDesign(.monospaced)
                    
                    Spacer()
                    Spacer()
                    
                } else {
                    Section("Ready, set, calculate! \nSolve \(currentMultiplier) x \(currentMultipliable)") {
                        TextField("", value: $answer, format: .number)
                            .padding(15)
                            .keyboardType(.numberPad)
                            .focused($inputFieldIsFocused)
                            .font(.title)
                            .background(.placeholder)
                            .clipShape(.rect(cornerRadius: 10))
                        
                        Button("Reveal!") {
                            checkAnswer()
                            submitAnswer = true
                        }
                        .padding(20)
                        .background(.regularMaterial)
                        .clipShape(.rect(cornerRadius: 10))
                        .font(.title2)
                        .fontWeight(.regular)
                        .foregroundStyle(.black)
                        .fontDesign(.monospaced)
                    }
                    .bold()
                    .font(.title)
                    .foregroundStyle(.black)
                    .fontDesign(.monospaced)
                    
                    Spacer()
                    Spacer()
                }
            }
            .navigationTitle("Edutainment")
            .padding()
            .alert(alertTitle, isPresented: $submitAnswer) {
                Button(restartMessage) {
                    askQuestion()
                }
            } message: {
                    Text(alertMessage)
            }
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputFieldIsFocused = false
                    }
                }
            }
        }
    }
    
    func checkAnswer() {
        guard let answer = answer else { return }
        
        let correctAnswer = currentMultiplier * currentMultipliable
        
        if questionsAsked == selectedQuestion - 1 {
            if correctAnswer == answer {
                score += 1
                alertTitle = "You Win!"
                alertMessage = "Score : \(score)"
            } else {
                alertTitle = "You Win!"
                alertMessage = "Score : \(score)"
            }
            restartMessage = "Restart"
            restart()
            questionVisible = false
            return
        } else {
            restartMessage = "Continue"
        }
        
        if correctAnswer == answer {
            score += 1
            alertTitle = "Bullseye!"
            alertMessage = "You nailed it! Score: \(score)"
        } else {
            alertTitle = "Oops, almost!"
            alertMessage = "Let's try again"
        }
    }
    
    func askQuestion() {
        answer = nil
        if selectedDifficultyLevel == "Beginner" {
            currentMultipliable = Int.random(in: 0...10)
        } else if selectedDifficultyLevel == "Intermediate" {
            currentMultipliable = Int.random(in: 5...20)
        } else if selectedDifficultyLevel == "Expert" {
            currentMultipliable = Int.random(in: 10...30)
        }
        questionsAsked += 1
    }
    
    func restart() {
        currentMultiplier = 2
        selectedQuestion = 5
        questionsAsked = 0
        score = 0
        answer = nil
    }
}

#Preview {
    ContentView()
}
