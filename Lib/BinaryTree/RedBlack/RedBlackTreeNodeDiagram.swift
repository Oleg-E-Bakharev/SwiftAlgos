//
//  RedBlackTreeNodeDiagram.swift
//  SwiftAlgosSandbox
//
//  Created by Oleg Bakharev on 21.08.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

public extension BinaryTreeNodeBase where Self: RedBlackTreeNode {
    static func diagram(of node: NodeRef?, top: String = "", root: String = "", bottom: String = "" ) -> String {
        guard let node = node else { return root + "nil\n" }

        if node.left == nil && node.right == nil {
            return root + "\(node)\n"
        }

        assert(!NodeRef.isRed(node.right))
        let leftColor = node.left == nil ? "" : (NodeRef.isRed(node.left) ? "🔴" : "⬤")
        let rightColor = node.right == nil ? "" : "⬤" // (NodeRef.isRed(node.right) ? "!!!!🔴!!!!" : "⬤")
        return diagram(of: node.right, top: top + "  ", root: top + "┌" + rightColor, bottom: top + "│ ")
        + root + "\(node)\n"
        + diagram(of: node.left, top: bottom + "│ ", root: bottom + "└" + leftColor, bottom: bottom + "  ")
    }
}
