//
//  BinaryTree+Extensions.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 31.07.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

extension BinaryTree: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Value...) {
        for element in elements {
            insert(element)
        }
    }
}

extension BinaryTree: ExpressibleByUnicodeScalarLiteral where Value == Character {
    public typealias UnicodeScalarLiteralType = Value
    public init(unicodeScalarLiteral value: Character) {
        insert(value)
    }
}

extension BinaryTree: ExpressibleByExtendedGraphemeClusterLiteral where Value == Character {
    public typealias ExtendedGraphemeClusterLiteralType = Value
    public init(extendedGraphemeClusterLiteral value: Character) {
        insert(value)
    }
}

extension BinaryTree: ExpressibleByStringLiteral where Value == Character {
    public typealias StringLiteralType = String
    public init(stringLiteral string: Self.StringLiteralType) {
        for character in string {
            insert(character)
        }
    }
}

extension BinaryTree: Sequence {
    // Implements in-order traverse. This allow to identical encode / decode.
    public struct Iterator: IteratorProtocol {
        public var ancestors: [Node] = []
        public var node: Node?

        public mutating func next() -> Value? {
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
