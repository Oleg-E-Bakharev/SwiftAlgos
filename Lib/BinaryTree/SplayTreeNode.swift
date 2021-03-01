//
//  SplayTreeNode.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 01.03.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import Foundation

public extension BinaryTreeNode {
    static func splaySearch(to hook: inout Self?, value: Value) -> Self? {
        guard var node = hook else { return nil }
        var result: Self? = nil
        if value == node.value {
            result = node
        } else if value < node.value {
            guard var left = node.left else {
                return nil }
            if value == left.value { // zig
                result = left
            } else if value < left.value { // zig-zig
                result = splaySearch(to: &left.left, value: value)
                if result != nil { Self.rotateRight(&hook) } // hook!
            } else { // zig-zag
                result = splaySearch(to: &left.right, value: value)
                if result != nil { Self.rotateLeft(&node.left) }
            }
            if result != nil { Self.rotateRight(&hook) }
        } else {
            guard var right = node.right else { return nil }
            if value == right.value { // zag
                result = right
            } else if value > right.value { // zag-zag
                result = splaySearch(to: &right.right, value: value)
                if result != nil { Self.rotateLeft(&hook) } // hook!
            } else { // zag-zig
                result = splaySearch(to: &right.left, value: value)
                if result != nil { Self.rotateRight(&node.right) }
            }
            if result != nil { Self.rotateLeft(&hook) }
        }
        return result
    }
}
