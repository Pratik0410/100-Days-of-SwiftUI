import Cocoa

enum squareRootError : Error {
    case outOfBounds, noRoot
}

func calculateSquareRoot(_ number : Int) throws -> Int {
    if number < 1 || number > 10000 {
        throw squareRootError.outOfBounds
    }
    for i in 1...100 {
        if number == (i*i) {
            return i
        }
    }
    throw squareRootError.noRoot
}

let number = Int.random(in: 1...100)
do {
    var result = try calculateSquareRoot(number)
    print("Square root : \(result)")
} catch squareRootError.outOfBounds {
    print("Error : \(number) out of bounds")
} catch squareRootError.noRoot {
    print("Error : No root found")
} catch {
    print("No root found")
}
