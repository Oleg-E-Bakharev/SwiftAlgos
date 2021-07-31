//
//  BinaryTreeTraits.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 16.02.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

public protocol BinaryTreeTraits {
    associatedtype Value
    associatedtype NodeRef: BinaryTreeNodeTraits where Value == NodeRef.Value, NodeRef.NodeRef == NodeRef

    var root: NodeRef? { get }

    var isEmpty: Bool { get }

    func search(_ value: Value) -> Bool

    func treeMin() -> Value?

    func treeMax() -> Value?

    mutating func insert(_ value: Value)

    @discardableResult
    mutating func remove(_ value: Value) -> Bool
}

extension BinaryTreeTraits {
    public var isEmpty: Bool { root == nil }

    public func search(_ value: Value) -> Bool {
        root?.search(value: value) != nil
    }

    public func treeMin() -> Value? {
        root?.min()?.value
    }

    public func treeMax() -> Value? {
        root?.max()?.value
    }
}
