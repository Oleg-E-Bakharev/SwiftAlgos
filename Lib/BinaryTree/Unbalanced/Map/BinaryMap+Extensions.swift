//
//  BinaryMap+Extensions.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 31.07.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

extension BinaryMap: ExpressibleByDictionaryLiteral {
    public init(dictionaryLiteral elements: (Key, Value)...) {
        for (key, value) in elements {
            insert(key: key, value: value)
        }
    }
}

extension BinaryMap: Sequence {
    // Implements in-order traverse. This allow to identical encode / decode.
    public struct Iterator: BinaryTreeNodeIterator, IteratorProtocol {
        public var ancestors: [Node] = []
        public var node: Node?

        public mutating func next() -> (Key, Value)? {
            guard let nextNode = nextNode() else { return nil }
            return (nextNode.key, nextNode.value)
        }
    }

    public __consuming func makeIterator() -> Iterator {
        return Iterator(node: root)
    }
}
