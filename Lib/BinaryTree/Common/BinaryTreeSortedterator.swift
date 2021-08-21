//
//  BinaryTreeNodeIterator.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 21.08.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

public protocol BinaryTreeSortedIterator {
    associatedtype Node: BinaryTreeNodeBase where Node.NodeRef == Node
    var ancestors: [Node] { get set}
    var node: Node? { get set }
    var visited: Bool { get set}

    mutating func nextNode() -> Node?
}

extension BinaryTreeSortedIterator {
    // In order traverse for sorted output
    public mutating func nextNode() -> Node? {
        guard var current = node else { return nil }
        if !visited {
            // return leftmost or self
            while let left = current.left {
                ancestors.append(current)
                current = left
            }
            visited = true
            node = current
        } else {
            // return right leftmost or parent
            node = current.right
            if let right = current.right {
                node = right
                visited = false
                return nextNode()
            } else {
                node = ancestors.popLast()
            }
        }
        return node
    }
}
