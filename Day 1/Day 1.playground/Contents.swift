import Cocoa

var name = "Ted"

/*
    "var" is used to create variables
    "name" is the variable
    "=" is the assignment operator to assign the value to variable "name"
    "Ted" is the value assigned to the variable "name"
    Value of the variables can be changed
*/

let character = "Rebecca"

/*
    "let" is used to create constants
    "character" is the constant
    "=" is the assignment operator to assign the value to variable "character"
    "Rebecca" is the value assigned to the variable "character"
    Value of the constants cannot be changed
*/

var playerName = "Roy"
print(playerName)

playerName = "Dani"
print(playerName)

playerName = "Sam"
print(playerName)

let managerName = "Michael Scott"
let dogBreed = "Samoyed"
let meaningOfLife = "How many roads must a man walk down?"

// Example of String

let movie = """
A day in
the life of an
Apple engineer
"""

let quote = "Then he tapped a sign saying \"Believe\" and walked away."

// Length of string
let length = movie.count
print(length)

// Convert the string into uppercase
let upperCase = managerName.uppercased()
print(upperCase)

// Printing string is having given prefix and suffix or not
print(movie.hasPrefix("A day"))

print(quote.hasSuffix("away."))

// Storing integer value in variable
let score = 10

let reallyBig = 100_000_000

// Operations on integer
let lowerScore = score - 2
let higherScore = score + 10
let doubledScore = score * 2
let squaredScore = score * score
let halvedScore = score / 2
print(score)

var counter = 10
counter = counter + 5

counter += 5
print(counter)

counter *= 2
print(counter)
counter -= 10
print(counter)
counter /= 2
print(counter)

// Using isMultiple(of: 3) to check whether the given number is multiple of 3 or not
let number = 120
print(number.isMultiple(of: 3))
print(120.isMultiple(of: 3))

// Storing decimal numbers
let Number = 0.1 + 0.2
print(Number)

// Adding integer number with decimal number
let a = 1
let b = 2.0
let c = a + Int(b)

let d = Double(a) + b

let double1 = 3.1
let double2 = 3131.3131
let double3 = 3.0
let int1 = 3

var rating = 5.0
rating *= 2
