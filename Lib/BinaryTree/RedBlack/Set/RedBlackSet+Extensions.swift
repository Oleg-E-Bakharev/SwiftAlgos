//
//  RedBlackSet+Extensions.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 31.07.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

extension RedBlackSet: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: T...) {
        for element in elements {
            insert(element)
        }
    }
}

extension RedBlackSet: ExpressibleByUnicodeScalarLiteral where T == Character {
    public typealias UnicodeScalarLiteralType = T
    public init(unicodeScalarLiteral value: Character) {
        insert(value)
    }
}

extension RedBlackSet: ExpressibleByExtendedGraphemeClusterLiteral where T == Character {
    public typealias ExtendedGraphemeClusterLiteralType = T
    public init(extendedGraphemeClusterLiteral value: Character) {
        insert(value)
    }
}

extension RedBlackSet: ExpressibleByStringLiteral where T == Character {
    public typealias StringLiteralType = String
    public init(stringLiteral string: Self.StringLiteralType) {
        for character in string {
            insert(character)
        }
    }
}

extension RedBlackSet: Sequence {
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
