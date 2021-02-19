//
//  public functions.swift
//  
//
//  Created by Franco Consoni on 22/12/2020.
//

import Foundation

let π = Double.pi

//MARK:- generic public functions
public func identity<T>(_ any: T) -> T {
    return any
}

public func appliedTo<T, U>(_ value: T) -> ((T) -> U) -> U {
    return { function in
        function(value)
    }
}

public func nop() {}

public func nop<T>(_ t: T) {}

public func nop<T, U>(_ t: T, _ u: U) {}

public func fst<A, B>(_ tuple: (A, B)) -> A {
    return tuple.0
}

public func snd<A, B>(_ tuple: (A, B)) -> B {
    return tuple.1
}

public func flip<A,B,C>(_ f: @escaping (A, B) -> C) -> (B, A) -> C {
    func mask(_ b: B, _ a: A) -> C {
        return f(a,b)
    }
    return mask
}

public func flip<A,B,C>(_ f: @escaping (A) -> (B) -> C) -> (B) -> (A) -> C {
    return { b in { a in f(a)(b) } }
}

//MARK:- currying public functions
public func curry<A,B,R>(_ f: @escaping (A, B) -> R) -> (A) -> (B) -> (R) {
    return { a in { b in f(a,b) } }
}

public func curry<A,B,C,R>(_ f: @escaping (A, B, C) -> R) -> (A) -> (B) -> (C) -> (R) {
    return { a in curry{ b, c in f(a,b,c) } }
}

public func curry<A,B,C,D,R>(_ f: @escaping (A, B, C, D) -> R) -> (A) -> (B) -> (C) -> (D) -> (R) {
    return { a in curry{ b, c, d in f(a,b,c,d) } }
}

public func curry<A,B,C,D,E,R>(_ f: @escaping (A, B, C, D, E) -> R) -> (A) -> (B) -> (C) -> (D) -> (E) -> (R) {
    return { a in curry{ b, c, d, e in f(a,b,c,d,e) } }
}

public func curry<A,B,C,D,E,F,R>(_ fx: @escaping (A, B, C, D, E, F) -> R) -> (A) -> (B) -> (C) -> (D) -> (E) -> (F) -> (R) {
    return { a in curry{ b, c, d, e, f in fx(a,b,c,d,e,f) } }
}

//MARK:- logic public functions
public func equalTo<A: Equatable>(_ elem: A) -> (A) -> Bool {
    return { otherElem in elem == otherElem }
}

public func isIn<T: Equatable>(_ elements: [T]) -> (T) -> Bool {
    return { element in
        elements.any(equalTo(element))
    }
}

public func not(_ value: Bool) -> Bool {
    return !value
}

//MARK:- numeric public functions
public func max<A: Comparable>(_ a: A) -> (A) -> A {
    return { b in Swift.max(a, b) }
}

public func min<A: Comparable>(_ a: A) -> (A) -> A {
    return { b in Swift.min(a, b) }
}

public func isEven(_ number: Int) -> Bool {
    return number % 2 == 0
}

public func between<A: Comparable>(_ a: A, and b: A) -> (A) -> A {
    return max(a) << min(b)
}

//MARK:- collection public function
public func length<A: Collection>(_ a: A) -> Int {
    return a.lazy.count
}

public func all<A: Collection>(_ condition: @escaping (A.Element) -> Bool) -> (A) -> Bool {
    return { collection in collection.all(condition) }
}

public func any<A: Collection>(_ condition: @escaping (A.Element) -> Bool) -> (A) -> Bool {
    return { collection in collection.any(condition) }
}

public func map<A, B>(_ fx: @escaping (A) -> B) -> ([A]) -> [B] {
    return { list in list.lazy.map(fx) }
}

public func filter<A>(_ condition: @escaping (A) -> Bool) -> ([A]) -> [A] {
    return { list in list.lazy.filter(condition) }
}

public func first<A>(_ list: [A]) -> A? {
    return list.lazy.first
}

public func replicate<A>(times: Int) -> (@autoclosure () -> A) -> [A] {
    return { value in Array(0..<times).map { _ in value() }}
}

//MARK:- logic public functions
prefix operator >
prefix public func > <A>(_ value: A) -> (A) -> Bool where A: Comparable {
    return { otherValue in otherValue > value }
}

prefix operator >!
prefix public func >! <A>(_ value: A) -> ((A) -> Bool) where A: Comparable {
    return flip(>)(value)
}

prefix operator /
prefix public func / <A>(_ num: A) -> (A) -> A where A: FloatingPoint {
    return { otherValue in otherValue / num }
}

//MARK:- composition public function
precedencegroup CompositionPrecedence {
    associativity: right
    higherThan: BitwiseShiftPrecedence
}

infix operator << : CompositionPrecedence
public func << <T,U,V>(_ f: @escaping (U) -> V, _ g: @escaping (T) -> U) -> (T) -> V {
    return { f(g($0)) }
}

public func << <T,U,V>(_ f: @escaping (U) -> V, _ keyPath: KeyPath<T, U>) -> (T) -> V {
    return { f($0[keyPath: keyPath]) }
}

public func << <T,U,V>(_ f: @escaping (U) -> V, _ g: @escaping (T) -> () -> (U)) -> (T) -> V {
    return { f(g($0)()) }
}


//MARK:- mathematic tools
precedencegroup PowPrecedence {
    associativity: left
    higherThan: MultiplicationPrecedence
}

infix operator **: PowPrecedence
public func ** (_ base: Int, _ power: Int) -> Float {
    return pow(Float(base), Float(power))
}
