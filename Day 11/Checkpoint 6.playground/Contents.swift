import Cocoa

struct Car {
    public let model: String
    public let seats: Int
    private(set) var currentGear: Int

    mutating func changeGears(by change: Int) {
        if currentGear + change > 10 {
            print("I don't have that many gears")
        } else if currentGear + change < 1 {
            print("Gear number can't be less than one")
        } else {
            currentGear += change
        }
    }
}

var BMW = Car(model: "BMW", seats: 5, currentGear: 6)
print("Current gear: \(BMW.currentGear)")
BMW.changeGears(by: 3)
print("Current gear: \(BMW.currentGear)")
BMW.changeGears(by: -12)
print("Current gear: \(BMW.currentGear)")
BMW.changeGears(by: 2)
print("Current gear: \(BMW.currentGear)")
