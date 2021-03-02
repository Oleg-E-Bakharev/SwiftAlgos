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

    public mutating func insert(_ value: T) {
        Node.insert(to: &root, value: value)
    }

    public mutating func insertToRoot(_ value: T) {
        var root = self.root
        Node.insertToRoot(to: &root, value: value)
        self.root = root
    }

    @discardableResult
    public mutating func remove(_ value: T) -> Bool {
        Node.remove(from: &root, value: value)
    }

    // Destructive to self merge O(n)
    public mutating func merge(to target: inout BinaryTree<T>) -> Void {
        target.root = Node.merge(target.root, to: root)
        root = nil
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

extension BinaryTree: BinaryTreeInfo {}

extension BinaryTree: CustomStringConvertible {
    public var description: String { diagram() }
}
