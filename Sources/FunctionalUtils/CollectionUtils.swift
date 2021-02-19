//
//  CollectionUtils.swift
//  
//
//  Created by Franco Consoni on 22/12/2020.
//

import Foundation

extension Sequence {
	public func map<T>(_ fx: (Element) -> () -> T) -> [T] {
		return lazy.map(fx).map{ $0() }
	}
}

extension Collection {
	public func all(_ condition: (Element) -> Bool) -> Bool {
		return self.lazy.allSatisfy(condition)
	}
	
	public func all(_ condition: (Element) -> () -> Bool) -> Bool {
		return self.lazy.map(condition).allSatisfy{ $0() }
	}
    
    func any(_ predicate: (Element) -> Bool)  -> Bool {
        return self.filter(predicate).count > 0
    }
}

extension Collection where Element == Bool {
	public func all() -> Bool {
		return self.lazy.allSatisfy{ $0 }
	}
}

extension Array {
	public func take(_ number: Int) -> [Element] {
		let index = Swift.min(number, self.count)
		return Array(self.prefix(through: index - 1))
	}
	
	public func tail() -> [Element] {
		if self.isEmpty {
			return []
		} else {
			return Array(self.suffix(self.count - 1))
		}
	}
}

extension String {
	public func words() -> [String] {
		return separateBy(" ")
	}
	
	public func separateBy(_ separator: String) -> [String] {
		return self.components(separatedBy: CharacterSet(charactersIn: separator))
	}
	
	public func trim() -> String {
		return self.trimmingCharacters(in: CharacterSet.whitespaces)
	}
}
