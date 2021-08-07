//
//  BinaryTreeNode+Splay.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 01.03.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

public extension BinaryTreeNode {
    typealias SplayOperation = (inout Self?, Value)->Self?

    static func splayEquivalence(_ node: inout Self?, _ value: Value)->Self? {
        node
    }

    static func splayInsertion(_ node: inout Self?, _ value: Value)->Self? {
        node = Self(value)
        return node
    }

    static func splayRemoving (_ node: inout Self?, _ value: Value)->Self? {
        Self.join(at: &node, left: node?.left, right: node?.right)
        return node
    }

    /// Universal splay operation
    @discardableResult
    static func splay(_ operation: SplayOperation, to link: inout Self?, value: Value) -> Self? {
        guard var node = link else { return operation(&link, value) }
        var result: Self?
        if value == node.value {
            result = operation(&link, value)
        } else if value < node.value {
            if var left = node.left {
                if value == left.value { // zig
                    result = operation(&node.left, value)
                } else if value < left.value { // zig-zig
                    result = splay(operation, to: &left.left, value: value)
                    if result != nil { Self.rotateRight(&link) } // link!
                } else { // zig-zag
                    result = splay(operation, to: &left.right, value: value)
                    if result != nil { Self.rotateLeft(&node.left) }
                }
            } else {
                return operation(&node.left, value)
            }
            if result != nil { Self.rotateRight(&link) }
        } else {
            if var right = node.right {
                if value == right.value { // zag
                    result = operation(&node.right, value)
                } else if value > right.value { // zag-zag
                    result = splay(operation, to: &right.right, value: value)
                    if result != nil { Self.rotateLeft(&link) } // link!
                } else { // zag-zig
                    result = splay(operation, to: &right.left, value: value)
                    if result != nil { Self.rotateRight(&node.right) }
                }
            } else {
                result = operation(&node.right, value)
            }
            if result != nil { Self.rotateLeft(&link) }
        }
        return result
    }
}