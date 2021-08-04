//
//  BinaryTree.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 02.02.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import Foundation

public struct BinaryTree<T: Comparable> {
    public typealias Value = T
    public final class Node: BinaryTreeNode, BinaryTreeNodeDeepCopy, BinaryTreeNodeTraits {
        public var value: T
        public var left: Node?
        public var right: Node?

        public init(_ value: T) {
            self.value = value
        }
    }

    public internal(set) var root: Node?

    // MARK: - Copy on write
    class UniqueMarker {}
    var uniqueMarker = UniqueMarker()
}

extension BinaryTree: BinaryTreeCopyOnWrite {
    public typealias NodeRef = Node
}

extension BinaryTree: BinaryTreeTraits {
    public func min() -> T? {
        treeMin()
    }

    public func max() -> T? {
        treeMax()
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

extension BinaryTree: BinaryTreeSerialOperations {}

extension BinaryTree: BinaryTreeInfo {}

extension BinaryTree: CustomStringConvertible {
    public var description: String { diagram() }
}
