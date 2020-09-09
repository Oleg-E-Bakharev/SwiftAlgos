//
//  Stack.swift
//  Algos
//
//  Created by Oleg Bakharev on 09.09.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import Foundation

public struct Stack<Element> {
    private var storage: [Element] = []
    
    public mutating func push(_ element: Element) {
        storage.append(element)
    }
    
    public init() {}
    
    public init(_ elements: [Element]) {
        storage = elements
    }
    
    @discardableResult
    public mutating func pop() -> Element? {
        storage.popLast()
    }
    
    public func peek() -> Element? {
        storage.last
    }
    
    public var isEmpty: Bool {
        peek() == nil
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
