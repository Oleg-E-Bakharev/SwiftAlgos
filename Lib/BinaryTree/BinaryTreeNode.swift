//
//  BinaryTreeNode.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 04.01.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import Foundation

// CustomStringConvertible for pretty print
public protocol BinaryTreeNode: CustomStringConvertible {
    associatedtype Value: Comparable & Equatable
    var value: Value { get set }
    var left: Self? { get set }
    var right: Self? { get set }

    init(_ value: Value)

    /// Returns node with searched value
    func search(value: Value) -> Self?
}

public extension BinaryTreeNode {
    func search(value: Value) -> Self? {
        if self.value == value {
            return self
        }
        if value < self.value {
            return left?.search(value: value) ?? nil
        }
        return right?.search(value: value) ?? nil
    }

    static func insert(to hook: inout Self?, value: Value) {
        guard var node = hook else {
            hook = Self(value)
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

    static func insertToRoot(to hook: inout Self?, value: Value) {
        guard var node = hook else {
            hook = Self(value)
            return
        }

        if value == node.value {
            node.value = value
        } else if value < node.value {
            insertToRoot(to: &node.left, value: value)
            Self.rotateRight(&hook)
        } else {
            insertToRoot(to: &node.right, value: value)
            Self.rotateLeft(&hook)
        }
    }

    static func remove(from hook: inout Self?, value: Value) -> Bool {
        guard var node = hook else {
            return false
        }
        if node.value == value {
            Self.join(at: &hook, left: node.left, right: node.right)
            return true
        }
        if value < node.value {
            return remove(from: &node.left, value: value)
        }
        return remove(from: &node.right, value: value)
    }

    // all left < all right
    static func join(at hook: inout Self?, left: Self?, right: Self?) {
        guard var l = left, var r = right else {
            hook = left != nil ? left : right
            return
        }

        if Bool.random() {
            join(at: &r.left, left: l, right: r.left)
            hook = r
        } else {
            join(at: &l.right, left: l.right, right: r)
            hook = l
        }
    }
    
    /// O(n)
    @discardableResult
    static func merge(_ left: Self?, to right: Self?) -> Self? {
        guard let left = left else { return right }
        guard right != nil else { return left }
        var right = right
        insertToRoot(to: &right, value: left.value)
        let rightLeft = merge(left.left, to: right?.left)
        right?.left = rightLeft
        let rightRight = merge(left.right, to: right?.right)
        right?.right = rightRight
        return right
    }

    static func rotateLeft(_ node: inout Self?) {
        var right = node?.right
        node?.right = right?.left
        right?.left = node
        node = right
    }

    static func rotateRight(_ node: inout Self?) {
        var left = node?.left
        node?.left = left?.right
        left?.right = node
        node = left
    }

    var description: String { String(describing: value) }
}
