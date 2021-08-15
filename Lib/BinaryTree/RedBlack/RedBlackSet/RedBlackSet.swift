//
//  RedBlackSet.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 31.07.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

public struct RedBlackSet<T: Comparable> {
    public typealias Value = T
    public typealias Key = T
    
    public final class Node: RedBlackTreeNode, BinaryTreeNodeDeepCopy, BinaryTreeNodeTraits {
        public var value: T
        public var key: T { value }
        public var left: Node?
        public var right: Node?
        private var isRed: Bool

        public init(key: T, value: T) {
            assert(key == value)
            self.value = value
            isRed = true
        }

        @inline(__always)
        public static func isRed(_ node: RedBlackSet<T>.Node?) -> Bool {
            node?.isRed ?? false
        }

        public static func setRed(_ node: inout RedBlackSet<T>.Node?, _ isRed: Bool) {
            node?.isRed = isRed
        }
    }

    public internal(set) var root: Node?

    // Marker for copy-on-write
    class UniqueMarker {}
    var uniqueMarker = UniqueMarker()
}

extension RedBlackSet: BinaryTreeCopyOnWrite {
    public typealias NodeRef = Node
}

extension RedBlackSet: BinaryTreeTraits {
    public func min() -> T? {
        treeMin()
    }

    public func max() -> T? {
        treeMax()
    }

    public mutating func insert(key: T, value: T) {
        copyNodesIfNotUnique()
        assert(key == value)
        Node.insert(key: key, value: value, to: &root)
    }

    public mutating func insert(_ key: T) {
        insert(key: key, value: key)
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

extension RedBlackSet: BinaryTreeSerialOperations {}

extension RedBlackSet.Node: Equatable {
    public static func == (lhs: RedBlackSet<T>.Node, rhs: RedBlackSet<T>.Node) -> Bool {
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

extension RedBlackSet: Equatable {
    public static func == (lhs: RedBlackSet<T>, rhs: RedBlackSet<T>) -> Bool {
        lhs.root == rhs.root
    }
}
