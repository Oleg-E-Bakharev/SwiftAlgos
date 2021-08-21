//
//  BinaryMap.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 02.02.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import Foundation

public struct BinaryMap<Key: Comparable, Value> {
    public final class Node: BinaryTreeNode, BinaryTreeNodeDeepCopy, BinaryTreeNodeTraits {
        public var key: Key
        public var value: Value
        public var left: Node?
        public var right: Node?

        public init(key: Key, value: Value) {
            self.key = key
            self.value = value
        }
    }

    public internal(set) var root: Node?

    // MARK: - Copy on write
    class UniqueMarker {}
    var uniqueMarker = UniqueMarker()
}

extension BinaryMap: BinaryTreeCopyOnWrite {
    public typealias NodeRef = Node
}

extension BinaryMap: BinaryTreeTraits {
    public func min() -> Value? {
        treeMin()
    }

    public func max() -> Value? {
        treeMax()
    }

    public mutating func insert(key: Key, value: Value) {
        copyNodesIfNotUnique()
        Node.insert(to: &root, key: key, value: value)
    }

    public mutating func insertToRoot(key: Key, value: Value) {
        copyNodesIfNotUnique()
        var root = self.root
        Node.insertToRoot(to: &root, key: key, value: value)
        self.root = root
    }

    @discardableResult
    public mutating func remove(_ key: Key) -> Bool {
        copyNodesIfNotUnique()
        return (Node.remove(from: &root, key: key) != nil)
    }

    // Destructive to self merge O(n)
    public mutating func merge(to target: inout BinaryMap) -> Void {
        target.root = Node.merge(target.root, to: root)
        root = nil
    }
}

extension BinaryMap.Node: Equatable where Value: Equatable {
    public static func == (lhs: BinaryMap<Key, Value>.Node, rhs: BinaryMap<Key, Value>.Node) -> Bool {
        guard lhs.key == rhs.key,
              lhs.value == rhs.value,
              lhs.left == rhs.left,
              lhs.right == rhs.right
        else {
            return false
        }
        return true
    }
}

extension BinaryMap: Equatable where Value: Equatable {
    public static func == (lhs: BinaryMap<Key, Value>, rhs: BinaryMap<Key, Value>) -> Bool {
        lhs.root == rhs.root
    }
}

extension BinaryMap: BinaryTreeSerialOperations {}

extension BinaryMap: BinaryTreeInfo {}

extension BinaryMap: CustomStringConvertible {
    public func diagram() -> String {
        NodeRef.diagram(of: root)
    }

    public var description: String { diagram() }
}
