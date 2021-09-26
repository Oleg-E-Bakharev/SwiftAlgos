//
//  List+Extensions.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 29.08.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

extension List: ExpressibleByArrayLiteral {
    public init(arrayLiteral values: Value...) {
        for value in values {
            append(value)
        }
    }
}

extension List: ExpressibleByUnicodeScalarLiteral where Value == Character {
    public typealias UnicodeScalarLiteralType = Value
    public init(unicodeScalarLiteral value: Character) {
        push(value)
    }
}

extension List: ExpressibleByExtendedGraphemeClusterLiteral where Value == Character {
    public typealias ExtendedGraphemeClusterLiteralType = Value
    public init(extendedGraphemeClusterLiteral value: Character) {
        push(value)
    }
}

extension List: ExpressibleByStringLiteral where Value == Character {
    public typealias StringLiteralType = String
    public init(stringLiteral string: Self.StringLiteralType) {
        for character in string {
            append(character)
        }
    }
}

extension List: Sequence {
    public struct Iterator: IteratorProtocol {
        public var node: Node?
        public mutating func next() -> Value? {
            defer {
                node = node?.next
            }
            return node?.value
        }
    }

    public __consuming func makeIterator() -> Iterator {
        return Iterator(node: head)
    }
}

extension List: CustomStringConvertible {
    public var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return "\(head)"
    }
}

extension List: Equatable where Value: Equatable {
    public static func == (lhs: List, rhs: List) -> Bool {
        lhs.head == rhs.head
    }
}
