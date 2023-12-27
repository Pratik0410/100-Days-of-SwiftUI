import Cocoa

class Animal {
    var legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
    
    func speak() {
        print("EEEEERRRRR")
    }
}

class Dog: Animal {
    init() {
        super.init(legs: 4)
    }
    
    override func speak() {
        print("Woof!")
    }
}

class Cat: Animal {
    var isTame: Bool
    
    init(isTame: Bool) {
        self.isTame = isTame
        super.init(legs: 4)
    }
    
    override func speak() {
        print("Meow!")
    }
}

class Corgi: Dog {
    override func speak() {
        print("Wwworf")
    }
}

class Poodle: Dog {
    override func speak() {
        print("Howwwow")
    }
}

class Persian: Cat {
    override func speak() {
        print("Purrrr")
    }
}

class Lion: Cat {
    override func speak() {
        print("Growwwwwwwwl")
    }
}

let abc = Poodle()
let def = Persian(isTame: true)
let ghi = Corgi()
let jkl = Lion(isTame: false)
let mno = Cat(isTame: false)
let pqr = Animal(legs: 6)

abc.speak()
def.speak()
ghi.speak()
jkl.speak()
mno.speak()
pqr.speak()

print(abc.legs)
print(pqr.legs)
