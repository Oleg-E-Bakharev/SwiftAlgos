//
//  main.swift
//  Algos
//
//  Created by Oleg Bakharev on 09.09.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import Foundation
import SwiftAlgosLib

final class SplayTreeNode<Value> : BinaryTreeNode {    
    public var value: Value
    public var left: SplayTreeNode?
    public var right: SplayTreeNode?
    
    public init(_ value: Value, left: SplayTreeNode? = nil, right: SplayTreeNode? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
}

final class AWLTreeNode<Value>: BinaryTreeNode {
    public var value: Value
    public var left: AWLTreeNode?
    public var right: AWLTreeNode?
    
    public init(_ value: Value, left: AWLTreeNode? = nil, right: AWLTreeNode? = nil) {
        self.value = value
        self.left = left
        self.right = right
    }
}

extension AWLTreeNode: CustomStringConvertible {
    var description: String { String(describing: value) }
}

struct SplayTree<Value> {
    var root: SplayTreeNode<Value>?
}

extension SplayTree: BinaryTreeInfo {
}

struct AWLTree<Value> {
    var root: AWLTreeNode<Value>?
}

extension AWLTree: BinaryTreeInfo {
}

extension SplayTree: CustomStringConvertible {
    var description: String { diagram() }
}

extension AWLTree: CustomStringConvertible {
    var description: String { diagram() }
}

typealias Node = AWLTreeNode<Int>

let zero = Node(0)
let one = Node(1)
let two = Node(2)
let three = Node(3)
let five = Node(5)
let seven = Node(7)
let eight = Node(8)
let nine = Node(9)

seven.left = one
seven.right = nine
one.left = zero
one.right = five
five.left = two
five.right = three
nine.left = eight

let tree = AWLTree(root: seven)

print(tree)

let nodePtr = BitPtr<Node>(zero)
nodePtr.bit = true
print(nodePtr.target ?? "nil", nodePtr.bit)
nodePtr.target = nil
print(nodePtr.target ?? "nil", nodePtr.bit)
