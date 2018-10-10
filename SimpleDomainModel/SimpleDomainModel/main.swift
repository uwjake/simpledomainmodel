//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Int
  public var currency : String
  
  public func convert(_ to: String) -> Money {
    var newAmount = 0
    switch currency {
    case "USD":
        switch to {
        case "GBP":
            newAmount = amount/2
        case "EUR":
            newAmount = amount/2*3
        case "CAN":
            newAmount = amount/4*5
        case "USD":
            newAmount = amount
        default:
            print("Error: Unsupported Currency")
        }
    case "EUR":
        switch to {
        case "GBP":
            newAmount = amount/3
        case "USD":
            newAmount = amount/3*2
        case "CAN":
            newAmount = amount/6*5
        case "EUR":
            newAmount = amount
        default:
            print("Error: Unsupported Currency")
        }
    case "GBP":
        switch to {
        case "EUR":
            newAmount = amount*3
        case "USD":
            newAmount = amount*2
        case "CAN":
            newAmount = amount/2*5
        case "GBP":
            newAmount = amount
        default:
            print("Error: Unsupported Currency")
        }
    case "CAN":
        switch to {
        case "EUR":
            newAmount = amount*6/5
        case "USD":
            newAmount = amount*4/5
        case "GBP":
            newAmount = amount*2/5
        default:
            print("Error: Unsupported Currency")
        }
    default:
        newAmount = amount
    }
    return Money(amount: newAmount, currency: to)
  }
  
  public func add(_ to: Money) -> Money {
    var newAmount = 0
    if to.currency == currency {
        newAmount = to.amount + amount
    } else{
    newAmount = to.amount + Money(amount: amount, currency: currency).convert(to.currency).amount
    }
    return Money(amount: newAmount, currency: to.currency)
  }
  public func subtract(_ from: Money) -> Money {
    var newAmount = 0
    if from.currency == currency {
    newAmount = from.amount - amount
    } else{
    newAmount = from.amount - Money(amount: amount, currency: currency).convert(from.currency).amount
    }
    return Money(amount: newAmount, currency: from.currency)
  }
}

////////////////////////////////////
// Job
//
open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }

  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
  }

  open func calculateIncome(_ hours: Int) -> Int {
    var income = 0
    switch self.type {
    case .Hourly(let wage):
        income = Int(wage * Double(hours))
    case .Salary(let salary):
        income = salary
    }
    return income
  }

//  open func raise(_ amt : Double) {
//  }
}

//////////////////////////////////////
//// Person
////
//open class Person {
//  open var firstName : String = ""
//  open var lastName : String = ""
//  open var age : Int = 0
//
//  fileprivate var _job : Job? = nil
//  open var job : Job? {
//    get { }
//    set(value) {
//    }
//  }
//
//  fileprivate var _spouse : Person? = nil
//  open var spouse : Person? {
//    get { }
//    set(value) {
//    }
//  }
//
//  public init(firstName : String, lastName: String, age : Int) {
//    self.firstName = firstName
//    self.lastName = lastName
//    self.age = age
//  }
//
//  open func toString() -> String {
//  }
//}
//
//////////////////////////////////////
//// Family
////
//open class Family {
//  fileprivate var members : [Person] = []
//
//  public init(spouse1: Person, spouse2: Person) {
//  }
//
//  open func haveChild(_ child: Person) -> Bool {
//  }
//
//  open func householdIncome() -> Int {
//  }
//}
//
//
//
//
//
