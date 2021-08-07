//
//  RedBlackTree.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 31.07.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//


public struct RedBlackTree<T: Comparable> {
    public typealias Value = T
    
    public final class Node: RedBlackTreeNode, BinaryTreeNodeDeepCopy, BinaryTreeNodeTraits {
        public var value: T
        public var left: Node?
        public var right: Node?
        private var isRed: Bool

        public init(_ value: T) {
            self.value = value
            isRed = true
        }

        public static func isRed(_ node: RedBlackTree<T>.Node?) -> Bool {
            node?.isRed ?? false
        }

        public static func setRed(_ node: inout RedBlackTree<T>.Node?, _ isRed: Bool) {
            node?.isRed = isRed
        }
    }

    public internal(set) var root: Node?

    // Marker for copy-on-write
    class UniqueMarker {}
    var uniqueMarker = UniqueMarker()
}

extension RedBlackTree: BinaryTreeCopyOnWrite {
    public typealias NodeRef = Node
}

extension RedBlackTree: BinaryTreeTraits {
    public func min() -> T? {
        treeMin()
    }

    public func max() -> T? {
        treeMax()
    }

    public mutating func insert(_ value: T) {
        copyNodesIfNotUnique()
        Node.insert(value, to: &root)
    }

    @discardableResult
    public mutating func remove(_ value: T) -> Bool {
        copyNodesIfNotUnique()
        return Node.remove(value, from: &root)
    }

    public mutating func removeMax() {
        copyNodesIfNotUnique()
        return Node.removeMax(at: &root)
    }

    public mutating func removeMin() {
        copyNodesIfNotUnique()
        return Node.removeMin(at: &root)
    }
}

extension RedBlackTree: BinaryTreeSerialOperations {}

extension RedBlackTree.Node: Equatable {
    public static func == (lhs: RedBlackTree<T>.Node, rhs: RedBlackTree<T>.Node) -> Bool {
        guard lhs.value == rhs.value,
              lhs.left == rhs.left,
              lhs.right == rhs.right,
              lhs.isRed == rhs.isRed
        else {
            return false
        }
        return true
    }
}

extension RedBlackTree: Equatable {
    public static func == (lhs: RedBlackTree<T>, rhs: RedBlackTree<T>) -> Bool {
        lhs.root == rhs.root
    }
}
