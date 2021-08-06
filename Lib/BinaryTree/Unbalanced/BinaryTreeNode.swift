//
//  BinaryTreeNode.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 04.01.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

public protocol BinaryTreeNode: BinaryTreeNodeTraits where NodeRef == Self {}

public extension BinaryTreeNode {
    static func insert(to link: inout NodeRef?, value: Value) {
        guard var node = link else {
            link = Self(value)
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

    static func insertToRoot(to link: inout Self?, value: Value) {
        guard var node = link else {
            link = Self(value)
            return
        }

        if value == node.value {
            node.value = value
        } else if value < node.value {
            insertToRoot(to: &node.left, value: value)
            Self.rotateRight(&link)
        } else {
            insertToRoot(to: &node.right, value: value)
            Self.rotateLeft(&link)
        }
    }

    static func remove(from link: inout Self?, value: Value) -> Bool {
        guard var node = link else {
            return false
        }
        if node.value == value {
            Self.join(at: &link, left: node.left, right: node.right)
            return true
        }
        if value < node.value {
            return remove(from: &node.left, value: value)
        }
        return remove(from: &node.right, value: value)
    }

    // all left < all right
    static func join(at link: inout Self?, left: Self?, right: Self?) {
        guard var l = left, var r = right else {
            link = left != nil ? left : right
            return
        }

        if Bool.random() {
            join(at: &r.left, left: l, right: r.left)
            link = r
        } else {
            join(at: &l.right, left: l.right, right: r)
            link = l
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

    // right becomes node
    static func rotateLeft(_ node: inout Self?) {
        var right = node?.right
        node?.right = right?.left
        right?.left = node
        node = right
    }

    // left becomes node
    static func rotateRight(_ node: inout Self?) {
        var left = node?.left
        node?.left = left?.right
        left?.right = node
        node = left
    }

    var description: String { String(describing: value) }
}
