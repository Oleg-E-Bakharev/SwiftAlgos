//
//  BinaryTree.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 02.02.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import Foundation

public struct BinaryTree<T: Comparable> : BinaryTreeSerialOperations {
    public typealias Value = T
    public final class Node: BinaryTreeNode {
        public var value: T
        public var left: Node?
        public var right: Node?

        public init(_ value: T) {
            self.value = value
        }
    }

    public internal(set) var root: Node?

    public var isEmpty: Bool { root == nil }

    public func search(_ value: T) -> Bool {
        root?.search(value: value) != nil
    }

    public func min() -> T? {
        root?.min()?.value
    }

    public func max() -> T? {
        root?.max()?.value
    }

    public mutating func insert(_ value: T) {
        copyNodesIfNotUnique()
        Node.insert(to: &root, value: value)
    }

    public mutating func insertToRoot(_ value: T) {
        copyNodesIfNotUnique()
        var root = self.root
        Node.insertToRoot(to: &root, value: value)
        self.root = root
    }

    @discardableResult
    public mutating func remove(_ value: T) -> Bool {
        copyNodesIfNotUnique()
        return Node.remove(from: &root, value: value)
    }

    // Destructive to self merge O(n)
    public mutating func merge(to target: inout BinaryTree) -> Void {
        target.root = Node.merge(target.root, to: root)
        root = nil
    }

    // Marker for copy-on-write
    private class UniqueMarker {}
    private var uniqueMarker = UniqueMarker()

    mutating func copyNodesIfNotUnique() {
        guard !isKnownUniquelyReferenced(&uniqueMarker) else {
            return
        }
        #if DEBUG
        print("*** \(#file) copy on write ***")
        #endif

        root = deepCopy(root)
    }

    private func deepCopy(_ node:Node?) -> Node? {
        guard let node = node else { return nil }
        let newNode = Node(node.value)
        newNode.left = deepCopy(node.left)
        newNode.right = deepCopy(node.right)
        return newNode
    }
}

extension BinaryTree.Node: Equatable {
    public static func == (lhs: BinaryTree<T>.Node, rhs: BinaryTree<T>.Node) -> Bool {
        guard lhs.value == rhs.value,
              lhs.left == rhs.left,
              lhs.right == rhs.right
        else {
            return false
        }
        return true
    }
}

extension BinaryTree: Equatable {
    public static func == (lhs: BinaryTree<T>, rhs: BinaryTree<T>) -> Bool {
        lhs.root == rhs.root
    }
}

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

extension BinaryTree: BinaryTreeInfo {}

extension BinaryTree: CustomStringConvertible {
    public var description: String { diagram() }
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

