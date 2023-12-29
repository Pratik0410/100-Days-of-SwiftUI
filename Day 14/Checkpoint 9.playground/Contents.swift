import Cocoa

func getNumber(array: [Int]?) -> Int {
    array?.randomElement() ?? Int.random(in: 1...100)
}

print(getNumber(array: [2, 9, 67, 89, 56, 7, 4, 12]))
