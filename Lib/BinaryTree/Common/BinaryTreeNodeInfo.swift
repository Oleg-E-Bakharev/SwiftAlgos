//
//  BinaryTreeNodeInfo.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 14.08.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

public extension BinaryTreeNodeBase {
    var description: String { "\(key): \(value)" }
}

public extension BinaryTreeNodeBase where Key == Value {
    var description: String { "\(value)" }
}

public extension BinaryTreeNodeBase {
    static func diagram(of node: NodeRef?, top: String = "", root: String = "", bottom: String = "" ) -> String {
        guard let node = node else { return root + "nil\n" }

        if node.left == nil && node.right == nil {
            return root + "\(node)\n"
        }

        return diagram(of: node.right, top: top + "  ", root: top + "┌─", bottom: top + "│ ")
            + root + "\(node)\n"
            + diagram(of: node.left, top: bottom + "│ ", root: bottom + "└─", bottom: bottom + "  ")
    }
}
