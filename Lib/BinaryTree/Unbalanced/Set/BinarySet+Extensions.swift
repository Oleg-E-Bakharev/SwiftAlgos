//
//  BinarySet+Extensions.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 31.07.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

extension BinarySet: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Value...) {
        for element in elements {
            insert(element)
        }
    }
}

extension BinarySet: ExpressibleByUnicodeScalarLiteral where Value == Character {
    public typealias UnicodeScalarLiteralType = Value
    public init(unicodeScalarLiteral value: Character) {
        insert(value)
    }
}

extension BinarySet: ExpressibleByExtendedGraphemeClusterLiteral where Value == Character {
    public typealias ExtendedGraphemeClusterLiteralType = Value
    public init(extendedGraphemeClusterLiteral value: Character) {
        insert(value)
    }
}

extension BinarySet: ExpressibleByStringLiteral where Value == Character {
    public typealias StringLiteralType = String
    public init(stringLiteral string: Self.StringLiteralType) {
        for character in string {
            insert(character)
        }
    }
}

extension BinarySet: Sequence {
    // Implements in-order traverse. This allow to identical encode / decode.
    public struct Iterator: BinaryTreeNodeIterator, IteratorProtocol {
        public var ancestors: [Node] = []
        public var node: Node?

        public mutating func next() -> Value? {  nextNode()?.value }
    }

    public __consuming func makeIterator() -> Iterator {
        return Iterator(node: root)
    }
}
