//
//  Stack.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 09.09.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import Foundation

public struct Stack<Element> {
    private var storage: [Element] = []
    
    /// O1
    public mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    public init() {}
    
    // On
    public init(_ elements: [Element]) {
        storage = elements
    }
    
    /// O1
    @discardableResult
    public mutating func pop() -> Element? {
        storage.popLast()
    }
    
    /// O1
    public func peek() -> Element? {
        storage.last
    }
    
    /// O1
    public var isEmpty: Bool {
        peek() == nil
    }
}

extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
}

extension Stack: Sequence {
    public struct Iterator: IteratorProtocol {
        public var stack: Stack
        public mutating func next() -> Element? {
            return stack.pop()
        }
    }
    
    public __consuming func makeIterator() -> Iterator {
        return Iterator(stack: self)
    }
}

extension Stack: CustomStringConvertible {
    public var description: String {
        """
        ---top---
        \(storage.map { "\($0)" }.reversed().joined(separator: "\n"))
        """
    }
}
