//
//  RedBlackMap+Extensions.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 21.08.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

extension RedBlackMap: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (Key, Value)...) {
        for (key, value) in elements {
            insert(key: key, value: value)
        }
    }
}

extension RedBlackMap: Sequence {
    public struct Iterator: BinaryTreeSortedIterator, IteratorProtocol {
        public var ancestors: [Node] = []
        public var node: Node?
        public var visited = false

        public mutating func next() -> (Key, Value)? {
            guard let nextNode = nextNode() else { return nil }
            return (nextNode.key, nextNode.value)
        }
    }

    public __consuming func makeIterator() -> Iterator {
        return Iterator(node: root)
    }
}
