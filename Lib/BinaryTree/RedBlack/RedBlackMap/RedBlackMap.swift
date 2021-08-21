//
//  RedBlackMap.swift
//  SwiftAlgosSandbox
//
//  Created by Oleg Bakharev on 21.08.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

public struct RedBlackMap<Key: Comparable, Value> {
    public final class Node: RedBlackTreeNode, BinaryTreeNodeDeepCopy, BinaryTreeNodeTraits {
        public var value: Value
        public var key: Key
        public var left: Node?
        public var right: Node?
        private var isRed: Bool

        public init(key: Key, value: Value) {
            self.key = key
            self.value = value
            isRed = true
        }

        @inline(__always)
        public static func isRed(_ node: RedBlackMap.Node?) -> Bool {
            node?.isRed ?? false
        }

        public static func setRed(_ node: inout RedBlackMap.Node?, _ isRed: Bool) {
            node?.isRed = isRed
        }
    }

    public internal(set) var root: Node?

    // Marker for copy-on-write
    class UniqueMarker {}
    var uniqueMarker = UniqueMarker()
}

extension RedBlackMap: BinaryTreeCopyOnWrite {
    public typealias NodeRef = Node
}

extension RedBlackMap: BinaryTreeTraits {
    public func min() -> Value? {
        treeMin()
    }

    public func max() -> Value? {
        treeMax()
    }

    public mutating func insert(key: Key, value: Value) {
        copyNodesIfNotUnique()
        Node.insert(key: key, value: value, to: &root)
    }

    @discardableResult
    public mutating func remove(_ value: Key) -> Bool {
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

extension RedBlackMap: BinaryTreeSerialOperations {}

extension RedBlackMap.Node: Equatable where Value: Equatable {
    public static func == (lhs: RedBlackMap.Node, rhs: RedBlackMap.Node) -> Bool {
        guard lhs.key == rhs.key,
              lhs.value == rhs.value,
              lhs.left == rhs.left,
              lhs.right == rhs.right,
              lhs.isRed == rhs.isRed
        else {
            return false
        }
        return true
    }
}

extension RedBlackMap: Equatable where Value: Equatable {
    public static func == (lhs: RedBlackMap, rhs: RedBlackMap) -> Bool {
        lhs.root == rhs.root
    }
}

extension RedBlackMap: CustomStringConvertible, BinaryTreeInfo {
    public func diagram() -> String {
        NodeRef.diagram(of: root)
    }

    public var description: String { diagram() }
}
