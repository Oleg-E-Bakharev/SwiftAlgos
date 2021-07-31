//
//  RedBlackTree+BinaryTreeInfo.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 31.07.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

extension RedBlackTree: BinaryTreeInfo {
    public func diagram() -> String {
        diagram(of: root)
    }

    private func diagram(of node: NodeRef?, top: String = "", root: String = "", bottom: String = "" ) -> String {
        guard let node = node else { return root + "nil\n" }

        if node.left == nil && node.right == nil {
            return root + "\(node)\n"
        }

        assert(!NodeRef.isRed(node.right))
        return diagram(of: node.right, top: top + "  ", root: top + "┌" + "b", bottom: top + "│ ")
        + root + "\(node)\n"
        + diagram(of: node.left, top: bottom + "│ ", root: bottom + "└" + (NodeRef.isRed(node.left) ? "r" : "b"), bottom: bottom + "  ")
    }
}
