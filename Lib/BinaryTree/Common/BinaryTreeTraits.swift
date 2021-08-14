//
//  BinaryTreeTraits.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 16.02.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

public protocol BinaryTreeTraits {
    associatedtype Key
    associatedtype Value
    associatedtype NodeRef: BinaryTreeNodeTraits where
        Key == NodeRef.Key,
        Value == NodeRef.Value,
        NodeRef.NodeRef == NodeRef

    var root: NodeRef? { get }

    var isEmpty: Bool { get }

    func search(_ key: Key) -> Value?

    func has(_ key: Key) -> Bool

    func treeMin() -> Value?

    func treeMax() -> Value?

    mutating func insert(key: Key, value: Value)

    @discardableResult
    mutating func remove(_ key: Key) -> Bool

    subscript(key: Key) -> Value? { get set }
}

extension BinaryTreeTraits {
    public var isEmpty: Bool { root == nil }

    public func search(_ key: Key) -> Value? {
        root?.search(key)?.value
    }

    public func has(_ key: Key) -> Bool {
        search(key) != nil
    }

    public func treeMin() -> Value? {
        root?.min()?.value
    }

    public func treeMax() -> Value? {
        root?.max()?.value
    }

    public subscript(key: Key) -> Value? {
        get { search(key) }
        set {
            if let value = newValue { insert(key: key, value: value) }
            else { remove(key) }
        }
    }
}
