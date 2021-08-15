//
//  RedBlackCompactSet+Extensions.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 31.07.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

extension RedBlackCompactSet: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: T...) {
        for element in elements {
            insert(element)
        }
    }
}

extension Character: RedBlackCompactKey {
    public static var defaultMin: Character {
        Character("\u{0}")
    }

    public static var defaultMax: Character {
        Character("\u{FFFFF}")
    }
}

extension RedBlackCompactSet: ExpressibleByUnicodeScalarLiteral where T == Character {
    public typealias UnicodeScalarLiteralType = T
    public init(unicodeScalarLiteral value: Character) {
        insert(value)
    }
}

extension RedBlackCompactSet: ExpressibleByExtendedGraphemeClusterLiteral where T == Character {
    public typealias ExtendedGraphemeClusterLiteralType = T
    public init(extendedGraphemeClusterLiteral value: Character) {
        insert(value)
    }
}

extension RedBlackCompactSet: ExpressibleByStringLiteral where T == Character {
    public typealias StringLiteralType = String
    public init(stringLiteral string: Self.StringLiteralType) {
        for character in string {
            insert(character)
        }
    }
}

extension RedBlackCompactSet: Sequence {
    // Implements in-order traverse. This allow to identical encode / decode.
    public struct Iterator: IteratorProtocol {
        public var ancestors: [Node] = []
        public var node: Node?

        public mutating func next() -> T? {
            var result: Value?
            guard let current = node else { return nil }
            result = current.value

            if let left = current.left {
                ancestors.append(current)
                node = left
            } else {
                // find unvisited right
                node = current.right
                while node == nil, !ancestors.isEmpty {
                    node = ancestors.popLast()?.right
                }
            }
            return result 
        }
    }

    public __consuming func makeIterator() -> Iterator {
        return Iterator(node: root)
    }
}
