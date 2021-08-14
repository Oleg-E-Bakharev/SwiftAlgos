//
//  BinarySetNodeTraits.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 31.07.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

public protocol BinarySetNodeTraits: BinarySetNodeBase {
    func search(_ key: Key) -> NodeRef?
    func min() -> NodeRef?
    func max() -> NodeRef?
}

public extension BinarySetNodeTraits where NodeRef == Self {
    func search(_ key: Key) -> NodeRef? {
        if self.key == key {
            return self
        }
        if key < self.key {
            return left?.search(key) ?? nil
        }
        return right?.search(key) ?? nil
    }

    func min() -> NodeRef? {
        left != nil ? left?.min() : self
    }

    func max() -> NodeRef? {
        right != nil ? right?.max() : self
    }
}
