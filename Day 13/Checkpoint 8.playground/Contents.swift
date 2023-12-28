import Cocoa

protocol Building {
    var rooms: Int { get }
    var cost: Int { get set }
    var agent: String { get set }
    func printSummary()
}

extension Building {
    func printSummary() {
        print("This building has \(rooms) rooms and it costs \(cost) bitcoins. Contact \(agent) for more detailed information.")
    }
}

struct House: Building {
    let rooms: Int
    var cost: Int
    var agent: String
}

struct Office: Building {
    let rooms: Int
    var cost: Int
    var agent: String

    func printSummary() {
        print("This office building has \(rooms) rooms and it costs \(cost) bitcoins. Contact \(agent) for more detailed information.")
    }
}

var utopia = House(rooms: 40, cost: 5000, agent: "Logan")
utopia.printSummary()
utopia.cost = 12000
utopia.printSummary()

var hexaware = Office(rooms: 20, cost: 60000, agent: "Mahesh")
hexaware.printSummary()
hexaware.agent = "Shiv"
hexaware.printSummary()
