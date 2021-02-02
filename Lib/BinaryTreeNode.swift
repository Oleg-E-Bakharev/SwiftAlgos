//
//  BinaryTreeNode.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 04.01.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import Foundation

public protocol BinaryTreeNode {
    associatedtype Value: Comparable & Equatable
    var value: Value { get set }
    var left: Self? { get set }
    var right: Self? { get set }

    /// Returns node with searched value
    func search(value: Value) -> Self?
}

public extension BinaryTreeNode {
    func search(value: Value) -> Self? {
        if self.value == value {
            return self
        }
        if value < self.value {
            return left?.search(value: value) ?? nil
        }
        return right?.search(value: value) ?? nil
    }
}
