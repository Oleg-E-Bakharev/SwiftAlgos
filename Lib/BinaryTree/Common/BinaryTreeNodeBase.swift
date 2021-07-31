//
//  BinaryTreeNodeBase.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 31.07.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

// CustomStringConvertible for pretty print
public protocol BinaryTreeNodeBase: CustomStringConvertible {
    associatedtype Value: Comparable & Equatable
    associatedtype NodeRef: BinaryTreeNodeBase where NodeRef.Value == Value, NodeRef.NodeRef == NodeRef

    var value: Value { get set }
    var left: NodeRef? { get set }
    var right: NodeRef? { get set }

    init(_ value: Value)
}
