//
//  BinaryTreeNodeIterator.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 21.08.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

public protocol BinaryTreeNodeIterator {
    associatedtype Node: BinaryTreeNodeBase where Node.NodeRef == Node
    var ancestors: [Node] { get set}
    var node: Node? { get set }

    mutating func nextNode() -> Node?
}

extension BinaryTreeNodeIterator {
    public mutating func nextNode() -> Node? {
        // Pre order traverse for identical encode / decode
        guard let current = node else { return nil }

        if let left = current.left {
            ancestors.append(current)
            node = left
        } else {
            // find unvisited right
            node = current.right
            while node == nil, !ancestors.isEmpty {
                node = ancestors.popLast()?.right
            }
        }
        return current
    }
}
