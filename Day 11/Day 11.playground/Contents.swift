import Cocoa

struct BankAccount {
    private(set) var funds = 0
    mutating func deposit(amount: Int) {
        funds += amount
    }
    mutating func withdraw(amount: Int) -> Bool {
        if funds >= amount {
            funds -= amount
            return true
        } else {
            return false
        }
    }
}

var account = BankAccount()
account.deposit(amount: 100)
let success = account.withdraw(amount: 200)
if success {
    print("Withdrew money successfully")
} else {
    print("Failed to get the money")
}
print(account.funds)

struct School {
    static var studentCount = 0
    static func add(student: String) {
        print("\(student) joined the school.")
        studentCount += 1
    }
}
School.add(student: "Taylor Swift")
print(School.studentCount)


