//
//  BinaryTreeNodeTraits.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 31.07.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

public protocol BinaryTreeNodeTraits: BinaryTreeNodeBase {
    func search(value: Value) -> NodeRef?
    func min() -> NodeRef?
    func max() -> NodeRef?
}

public extension BinaryTreeNodeTraits where NodeRef == Self {
    func search(value: Value) -> NodeRef? {
        if self.value == value {
            return self
        }
        if value < self.value {
            return left?.search(value: value) ?? nil
        }
        return right?.search(value: value) ?? nil
    }

    func min() -> NodeRef? {
        left != nil ? left?.min() : self
    }

    func max() -> NodeRef? {
        right != nil ? right?.max() : self
    }
}
