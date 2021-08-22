//
//  RedBlackTaggedSet.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 22.08.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//
// Balanced binary tree with doubly linked list memory layout!!!
// Built on tagged pointers.

public struct RedBlackTaggedSet<T: Comparable> {
    public typealias Value = T
    public typealias Key = T

    public final class Node: RedBlackTreeNode, BinaryTreeNodeDeepCopy, BinaryTreeNodeTraits {
        public var _left = BitPtr<Node>(nil)
        public var _right = BitPtr<Node>(nil)
        public var value: T

        public var key: T { value }
        public var left: Node? {
            get { _left.target }
            set { _left ~= newValue }
        }
        public var right: Node? {
            get { _right.target }
            set { _right ~= newValue }
        }

        public init(key: T, value: T) {
            assert(key == value)
            self.value = value
            var node: Node? = self
            Node.setRed(&node, true)
        }

        @inline(__always)
        public static func isRed(_ node: Node?) -> Bool {
            node?._left.bit ?? false
        }

        @inline(__always)
        public static func setRed(_ node: inout Node?, _ isRed: Bool) {
            node?._left.bit = isRed
        }

        @inline(__always)
        public func copyData(from node: Node) {
            value = node.value
        }
    }

    public internal(set) var root: Node?

    // Marker for copy-on-write
    class UniqueMarker {}
    var uniqueMarker = UniqueMarker()
}

extension RedBlackTaggedSet: BinaryTreeCopyOnWrite {
    public typealias NodeRef = Node
}

extension RedBlackTaggedSet: BinaryTreeTraits {
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
    public mutating func remove(_ key: T) -> Bool {
        copyNodesIfNotUnique()
        return Node.remove(key, from: &root)
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

extension RedBlackTaggedSet: BinaryTreeSerialOperations {}

extension RedBlackTaggedSet.Node: Equatable {
    public static func == (lhs: NodeRef, rhs:NodeRef) -> Bool {
        guard lhs.value == rhs.value,
              lhs.left == rhs.left,
              lhs.right == rhs.right,
              isRed(lhs) == isRed(rhs)
        else {
            return false
        }
        return true
    }
}

extension RedBlackTaggedSet: Equatable {
    public static func == (lhs: RedBlackTaggedSet, rhs: RedBlackTaggedSet) -> Bool {
        lhs.root == rhs.root
    }
}

extension RedBlackTaggedSet: CustomStringConvertible, BinaryTreeInfo {
    public func diagram() -> String {
        NodeRef.diagram(of: root)
    }

    public var description: String { diagram() }
}
