//
//  BinarySet.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 02.02.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import Foundation

public struct BinarySet<T: Comparable> {
    public typealias Value = T
    public typealias Key = T
    public final class Node: BinaryTreeNode, BinaryTreeNodeDeepCopy, BinaryTreeNodeTraits {
        public var value: T
        public var key: T { value }
        public var left: Node?
        public var right: Node?

        public init(key: T, value: T) {
            assert(key == value)
            self.value = value
        }

        public init(_ value: T) {
            self.value = value
        }
    }

    public internal(set) var root: Node?

    // MARK: - Copy on write
    class UniqueMarker {}
    var uniqueMarker = UniqueMarker()
}

extension BinarySet: BinaryTreeCopyOnWrite {
    public typealias NodeRef = Node
}

extension BinarySet: BinaryTreeTraits {
    public func min() -> T? {
        treeMin()
    }

    public func max() -> T? {
        treeMax()
    }

    public mutating func insert(key: T, value: T) {
        copyNodesIfNotUnique()
        Node.insert(to: &root, key: key, value: value)
    }

    public mutating func insert(_ key: T) {
        insert(key: key, value: key)
    }

    public mutating func insertToRoot(_ value: T) {
        copyNodesIfNotUnique()
        var root = self.root
        Node.insertToRoot(to: &root, key: value, value: value)
        self.root = root
    }

    @discardableResult
    public mutating func remove(_ key: T) -> Bool {
        copyNodesIfNotUnique()
        return (Node.remove(from: &root, key: key) != nil)
    }

    // Destructive to self merge O(n)
    public mutating func merge(to target: inout BinarySet) -> Void {
        target.root = Node.merge(target.root, to: root)
        root = nil
    }
}

extension BinarySet.Node: Equatable {
    public static func == (lhs: BinarySet<T>.Node, rhs: BinarySet<T>.Node) -> Bool {
        guard lhs.value == rhs.value,
              lhs.left == rhs.left,
              lhs.right == rhs.right
        else {
            return false
        }
        return true
    }
}

extension BinarySet: Equatable {
    public static func == (lhs: BinarySet<T>, rhs: BinarySet<T>) -> Bool {
        lhs.root == rhs.root
    }
}

extension BinarySet: BinaryTreeSerialOperations {}

extension BinarySet: BinaryTreeInfo {}

extension BinarySet: CustomStringConvertible {
    public var description: String { diagram() }
}
