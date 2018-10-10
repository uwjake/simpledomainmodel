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

  open func raise(_ amt : Double) {
    switch self.type {
    case .Hourly(let wage):
        self.type = JobType.Hourly(wage + amt)
    case .Salary(let salary):
        self.type = JobType.Salary(salary + Int(amt))
    }
  }
}

//////////////////////////////////////
//// Person
////
open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0

  fileprivate var _job : Job? = nil
  open var job : Job? {
    get {return self._job}
    set(value) {
        if self.age > 15 {
            self._job = value
        }
    }
  }

  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get { return self._spouse }
    set(value) {
        if self.age >= 18{
            self._spouse = value
        }
    }
  }

  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }

  open func toString() -> String {
    return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(String(describing: job)) spouse:\(String(describing: spouse))]"
  }
}

//////////////////////////////////////
//// Family
////
open class Family {
  fileprivate var members : [Person] = []

  public init(spouse1: Person, spouse2: Person) {
    if (spouse1.spouse != nil && spouse2.spouse != nil) {
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
        self.members.append(spouse1)
        self.members.append(spouse2)
    }
  }

//  open func haveChild(_ child: Person) -> Bool {
//  }
//
  open func householdIncome() -> Int {
    var totalIncome = 0
    for member in members{
        print(member)
        if member.job != nil {
            print(member.job!.calculateIncome(2000))
            totalIncome += member.job!.calculateIncome(2000)
        }
    }
    print("income")
    print(totalIncome)
    return totalIncome
  }
}


