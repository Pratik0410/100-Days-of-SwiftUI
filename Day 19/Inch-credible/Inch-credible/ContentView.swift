//
//  ContentView.swift
//  Inch-credible
//
//  Created by Prathamesh Sonawane on 04/01/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputValue = 0.0
    @State private var outputValue = 0.0
    @State private var inputLength = "METERS"
    @State private var outputLength = "METERS"
    @FocusState private var inputFocus : Bool
    
    let length = ["METERS", "KMS", "FEET", "YARDS", "MILES"]
    
    var convertedValue : Double {
        if inputLength == "METERS" && outputLength == "KMS" {
            return inputValue / 1000
        }
        else if inputLength == "METERS" && outputLength == "FEET" {
            return inputValue * 3.28084
        }
        else if inputLength == "METERS" && outputLength == "YARDS" {
            return inputValue * 1.09361
        }
        else if inputLength == "METERS" && outputLength == "MILES" {
            return inputValue / 1609.34
        }
        else if inputLength == "KMS" && outputLength == "METERS" {
            return inputValue * 1000
        }
        else if inputLength == "KMS" && outputLength == "FEET" {
            return inputValue * 3280.84
        }
        else if inputLength == "KMS" && outputLength == "YARDS" {
            return inputValue * 1093.61
        }
        else if inputLength == "KMS" && outputLength == "MILES" {
            return inputValue / 1.60934
        }
        else if inputLength == "FEET" && outputLength == "METERS" {
            return inputValue / 3.28084
        }
        else if inputLength == "FEET" && outputLength == "KMS" {
            return inputValue / 3280.84
        }
        else if inputLength == "FEET" && outputLength == "YARDS" {
            return inputValue / 3
        }
        else if inputLength == "FEET" && outputLength == "MILES" {
            return inputValue / 5280
        }
        else if inputLength == "YARDS" && outputLength == "METERS" {
            return inputValue * 0.9144
        }
        else if inputLength == "YARDS" && outputLength == "KMS" {
            return inputValue * 0.9144 / 1000
        }
        else if inputLength == "YARDS" && outputLength == "FEET" {
            return inputValue * 3
        }
        else if inputLength == "YARDS" && outputLength == "MILES" {
            return inputValue / 1760
        }
        else if inputLength == "MILES" && outputLength == "METERS" {
            return inputValue * 1609.34
        }
        else if inputLength == "MILES" && outputLength == "KMS" {
            return inputValue * 1.60934
        }
        else if inputLength == "MILES" && outputLength == "FEET" {
            return inputValue * 5280
        }
        else if inputLength == "MILES" && outputLength == "YARDS" {
            return inputValue * 1760
        }
        return inputValue
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Tape It Up") {
                    TextField(" ", value: $inputValue, format: .number).keyboardType(.decimalPad).focused($inputFocus)
                }
                
                Section("Anchor Your Scale") {
                    Picker("Convert from : ", selection: $inputLength) {
                        ForEach(length, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section("Secure the Destination") {
                    Picker("Convert from : ", selection: $outputLength) {
                        ForEach(length, id: \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                }
                
                Section("Conversion Crafted") {
                    Text(convertedValue, format: .number)
                }
            }.navigationTitle("Inch-credible")
            .toolbar {
                if inputFocus {
                    Button("Done") {
                        inputFocus = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
