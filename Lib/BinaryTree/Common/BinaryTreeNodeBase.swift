//
//  BinaryTreeNodeBase.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 31.07.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

// CustomStringConvertible for pretty print
public protocol BinaryTreeNodeBase: CustomStringConvertible {
    associatedtype Key: Comparable & Equatable
    associatedtype Value
    associatedtype NodeRef: BinaryTreeNodeBase where NodeRef.Key == Key, NodeRef.NodeRef == NodeRef

    var key: Key { get }
    var value: Value { get set }
    var left: NodeRef? { get set }
    var right: NodeRef? { get set }

    init(key: Key, value: Value)
}
