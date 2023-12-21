import Cocoa

func displayHelp() {
    print("Welcome to my app!")
    print("By default This prints out a conversion")
    print("chart from centimeters to inches, but you")
    print("can also set a custom range if you want.")
}

displayHelp()

let number = 120

if number.isMultiple(of: 2) {
    print("Even")
} else {
    print("Odd")
}

func printTimesTables(number: Int) {
    for i in 1...10 {
        print("\(i) x \(number) is \(i * number)")
    }
}
printTimesTables(number: 28)

func printTimesTables(number: Int, end: Int) {
    for i in 1...end {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(number: 14, end: 12)

let num = sqrt(169)
print(num)

func rollDice() -> Int {
    return Int.random(in: 1...6)
}
// or

/*
 func rollDice() -> Int {
     Int.random(in: 1...6)
 }
*/

let result = rollDice()
print(result)

func areLettersIdentical(string1: String, string2: String) -> Bool {
    let first = string1.sorted()
    let second = string2.sorted()
    return first == second
}

// or

/*
func areLettersIdentical(string1: String, string2: String) -> Bool {
    return string1.sorted() == string2.sorted()
}
*/

// or

/*
 func areLettersIdentical(string1: String, string2: String) -> Bool {
     string1.sorted() == string2.sorted()
 }
*/

/*
 func pythagoras(a: Double, b: Double) -> Double {
     let input = a * a + b * b
     let root = sqrt(input)
     return root
 }
*/

// or

func pythagoras(a: Double, b: Double) -> Double {
    sqrt(a * a + b * b)
}

let c = pythagoras(a: 3, b: 4)
print(c)

func getUser() -> (firstName: String, lastName: String) {
    (firstName: "Taylor", lastName: "Swift")
}

let user = getUser()
print("Name: \(user.firstName) \(user.lastName)")

// or

/*
 func getUser() -> (firstName: String, lastName: String) {
     ("Taylor", "Swift")
 }
*/

// or

/*
 func getUser() -> (String, String) {
     ("Taylor", "Swift")
 }
 let user = getUser()
 print("Name: \(user.0) \(user.1)")
*/

// or

/*
 func getUser() -> (firstName: String, lastName: String) {
     (firstName: "Taylor", lastName: "Swift")
 }
 let user = getUser()
 let firstName = user.firstName
 let lastName = user.lastName
 print("Name: \(firstName) \(lastName)")
*/

let (firstName, lastName) = getUser()
print("Name: \(firstName) \(lastName)")

// or

/*
 let (firstName, _) = getUser()
 print("Name: \(firstName)")
*/

func rollDice(sides: Int, count: Int) -> [Int] {
    var rolls = [Int]()
    for _ in 1...count {
        let roll = Int.random(in: 1...sides)
        rolls.append(roll)
    }
    return rolls
}
let rolls = rollDice(sides: 6, count: 4)

func isUppercase(_ string: String) -> Bool {
    string == string.uppercased()
}
let string = "HELLO, WORLD"
let result1 = isUppercase(string)

func printTimesTables(for number: Int) {
    for i in 1...10 {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(for: 8)
