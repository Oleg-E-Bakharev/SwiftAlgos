//
//  RedBlackTreeNode.swift
//  SwiftAlgosSandbox
//
//  Created by Oleg Bakharev on 25.07.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

public protocol RedBlackTreeNode: BinaryTreeNodeTraits where NodeRef: RedBlackTreeNode {
//    NodeRef.Value == Value,
//    NodeRef.NodeRef == NodeRef {
    //    associatedtype Value: Comparable & Equatable

    //    var value: Value { get set }
    //    var left: NodeRef? { get set }
    //    var right: NodeRef? { get set }

    //    init(_ value: Value)

    static func isRed(_ node: NodeRef?) -> Bool
    static func setRed(_ node: inout NodeRef?, _ isRed: Bool)
}

public extension RedBlackTreeNode {
//    func search(value: Value) -> Bool {
//        if self.value == value { return true }
//        if value < self.value {
//            return left?.search(value: value) ?? false
//        }
//        return right?.search(value: value) ?? false
//    }
//
//    func min() -> Value {
//        left?.min() ?? value
//    }
//
//    func max() -> Value {
//        right?.max() ?? value
//    }

    /// Flips color of node and its children
    static func colorFlip(node: inout NodeRef?) {
        setRed(&node, !isRed(node))
        if var node = node {
            setRed(&node.left, !isRed(node.left))
            setRed(&node.right, !isRed(node.right))
        }
    }

    // right becomes node
    static func rotateLeft(_ node: inout NodeRef?) {
        var right = node?.right
        setRed(&right, isRed(node))
        setRed(&node, true) // We will rotate only red nbodes
        node?.right = right?.left
        right?.left = node
        node = right
    }

    // left becomes node
    static func rotateRight(_ node: inout NodeRef?) {
        var left = node?.left
        setRed(&left, isRed(node))
        setRed(&node, true) // We will rotate only red nbodes
        node?.left = left?.right
        left?.right = node
        node = left
    }

    static func insert(to node: inout NodeRef?, value: Value) {
        if node == nil {
            node = .init(value)
            setRed(&node, true)
            return
        }

        if var node = node {
            if value < node.value {
                insert(to: &node.left, value: value)
            } else {
                insert(to: &node.right, value: value)
            }
        }

        fix(&node)
    }

    static func fix(_ node: inout NodeRef?) {
        if isRed(node?.right) && !isRed(node?.left) {
            rotateLeft(&node)
        }
        if isRed(node?.left) && isRed(node?.left?.left) {
            rotateRight(&node)
        }
        if isRed(node?.left) && isRed(node?.right) {
            colorFlip(node: &node)
        }
    }

    var description: String { String(describing: value) }
}
