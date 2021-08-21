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
    public struct Iterator: IteratorProtocol {
        public var ancestors: [Node] = []
        public var node: Node?

        public mutating func next() -> (Key, Value)? {
            var result: (Key, Value)?
            guard let current = node else { return nil }
            result = (current.key, current.value)

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
