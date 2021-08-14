//
//  BinarySetNode.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 04.01.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

public protocol BinarySetNode: BinarySetNodeTraits where NodeRef == Self {}

public extension BinarySetNode {
    static func insert(to link: inout NodeRef?, key: Key, value: Value) {
        guard var node = link else {
            link = Self(key: key, value: value)
            return
        }
 
        if key == node.key {
            link = Self(key: key, value: value)
        } else if key < node.key {
            insert(to: &node.left, key: key, value: value)
        } else {
            insert(to: &node.right, key: key, value: value)
        }
    }

    static func insertToRoot(to link: inout NodeRef?, key: Key, value: Value) {
        guard var node = link else {
            link = Self(key: key, value: value)
            return
        }

        if key == node.key {
            link = node
        } else if key < node.key {
            insertToRoot(to: &node.left, key: key, value: value)
            Self.rotateRight(&link)
        } else {
            insertToRoot(to: &node.right, key: key, value: value)
            Self.rotateLeft(&link)
        }
    }

    static func remove(from link: inout NodeRef?, key: Key) -> Value? {
        guard var node = link else {
            return nil
        }
        if node.key == key {
            Self.join(at: &link, left: node.left, right: node.right)
            return node.value
        }
        if key < node.key {
            return remove(from: &node.left, key: key)
        }
        return remove(from: &node.right, key: key)
    }

    // all left < all right
    static func join(at link: inout NodeRef?, left: Self?, right: Self?) {
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
    static func merge(_ left: NodeRef?, to right: NodeRef?) -> NodeRef? {
        guard let left = left else { return right }
        guard right != nil else { return left }
        var right = right
        /// Ошибка!
        insertToRoot(to: &right, key: left.key, value: left.value)
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
