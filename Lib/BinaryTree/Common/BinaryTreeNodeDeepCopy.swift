//
//  BinaryTreeNodeDeepCopy.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 03.08.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

protocol BinaryTreeNodeDeepCopy: BinaryTreeNodeBase {
    static func deepCopy(_ node: NodeRef?) -> NodeRef?
}

extension BinaryTreeNodeDeepCopy {
    static func deepCopy(_ node:NodeRef?) -> NodeRef? {
        guard let node = node else { return nil }
        var newNode = NodeRef(key: node.key, value: node.value)
        newNode.left = deepCopy(node.left)
        newNode.right = deepCopy(node.right)
        return newNode
    }
}
