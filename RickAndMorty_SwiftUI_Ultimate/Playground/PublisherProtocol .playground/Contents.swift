import UIKit

protocol Publisher<Output, Failure> {
    typealias Failure = Error
    typealias Output = Output
    
    func receive<Subscriber>(subscriber: Subscriber) where Subscriber: Subscriber
}

struct Person {
    var name: String
    var age: Int
}

let person1 = Person(name: "John", age: 20)
