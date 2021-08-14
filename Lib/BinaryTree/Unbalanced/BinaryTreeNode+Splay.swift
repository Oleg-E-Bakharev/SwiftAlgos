//
//  BinaryTreeNode+Splay.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 01.03.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

public extension BinaryTreeNode {
    typealias SplayOperation = (inout Self?, Key, NodeRef?) -> Self?

    static func splayEquivalence(at link: inout Self?, key: Key, newNode: NodeRef?) -> Self? {
        link
    }

    static func splayInsertion(_ link: inout Self?, key: Key, newNode: NodeRef?) -> Self? {
        link = newNode
        return link
    }

    static func splayRemoving (_ link: inout Self?, key: Key, newNode: NodeRef?) -> Self? {
        Self.join(at: &link, left: link?.left, right: link?.right)
        return link
    }

    /// Universal splay operation
    @discardableResult
    static func splay(_ operation: SplayOperation, to link: inout Self?, key: Key, newNode: NodeRef? = nil) -> Self? {
        guard var node = link else { return operation(&link, key, newNode) }
        var result: Self?
        if key == node.key {
            result = operation(&link, key, newNode)
        } else if key < node.key {
            if var left = node.left {
                if key == left.key { // zig
                    result = operation(&node.left, key, newNode)
                } else if key < left.key { // zig-zig
                    result = splay(operation, to: &left.left, key: key, newNode: newNode)
                    if result != nil { Self.rotateRight(&link) } // link!
                } else { // zig-zag
                    result = splay(operation, to: &left.right, key: key, newNode: newNode)
                    if result != nil { Self.rotateLeft(&node.left) }
                }
            } else {
                return operation(&node.left, key, newNode)
            }
            if result != nil { Self.rotateRight(&link) }
        } else {
            if var right = node.right {
                if key == right.key { // zag
                    result = operation(&node.right, key, newNode)
                } else if key > right.key { // zag-zag
                    result = splay(operation, to: &right.right, key: key, newNode: newNode)
                    if result != nil { Self.rotateLeft(&link) } // link!
                } else { // zag-zig
                    result = splay(operation, to: &right.left, key: key, newNode: newNode)
                    if result != nil { Self.rotateRight(&node.right) }
                }
            } else {
                result = operation(&node.right, key, newNode)
            }
            if result != nil { Self.rotateLeft(&link) }
        }
        return result
    }
}
