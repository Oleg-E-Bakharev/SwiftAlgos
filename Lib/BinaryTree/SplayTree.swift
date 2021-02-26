//
//  SplayTree.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 26.02.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import Foundation

public struct SplayTree<T: Comparable> : BinaryTreeSerialOperations {
    public typealias Value = T
    public final class Node: BinaryTreeNode {
        public var value: T
        public var left: Node?
        public var right: Node?

        init(_ value: T) {
            self.value = value
        }
    }

    public internal(set) var root: Node?

    public var isEmpty: Bool { root == nil }

    public func search(value: T) -> Bool {
        root?.search(value: value) != nil
    }

    public mutating func insert(_ value: T) {
        insert(to: &root, value: value)
    }

    @discardableResult
    public mutating func remove(_ value: T) -> Bool {
        remove(from: &root, value: value)
    }
}

private extension SplayTree {
    func insert(to hook: inout Node?, value: T) {
        guard let node = hook else {
            hook = Node(value)
            return
        }

        if value == node.value {
            node.value = value
        } else if value < node.value {
            insert(to: &node.left, value: value)
        } else {
            insert(to: &node.right, value: value)
        }
    }

    func remove(from hook: inout Node?, value: T) -> Bool {
        guard let node = hook else {
            return false
        }
        if node.value == value {
            merge(at: &hook, left: node.left, right: node.right)
            return true
        }
        if value < node.value {
            return remove(from: &node.left, value: value)
        }
        return remove(from: &node.right, value: value)
    }

    func merge(at hook: inout Node?, left: Node?, right: Node?) {
        guard let l = left, let r = right else {
            hook = left != nil ? left : right
            return
        }

        merge(at: &r.left, left: l, right: r.left)
        hook = r
    }
}
