//
//  RedBlackCompactSet+Extensions.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 31.07.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

extension RedBlackCompactSet: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: T...) {
        Storage.minAnchor = Node(.defaultMin)
        Storage.maxAnchor = Node(.defaultMax)
        
        for element in elements {
            insert(element)
        }
    }
}

extension Character: RedBlackCompactKey {
    public static var defaultMin: Character { Character("\u{0}") }

    public static var defaultMax: Character { Character("\u{FFFFF}") }
}

extension String: RedBlackCompactKey {
    public static var defaultMin: String { "" }

    public static var defaultMax: String { "\u{FFFFF}" }
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
    public struct Iterator: BinaryTreeSortedIterator, IteratorProtocol {
        public var ancestors: [Node] = []
        public var node: Node?
        public var visited = false

        public mutating func next() -> Value? {  nextNode()?.value }
    }

    public __consuming func makeIterator() -> Iterator {
        return Iterator(node: root)
    }
}
