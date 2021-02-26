//
//  BinaryTreeRotation.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 05.01.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import Foundation

public protocol BinaryTreeRotation {
    associatedtype Node
    
    // right becomes top
    mutating func rotateLeft(_ node: inout Node?)
    
    // left becomes top
    mutating func rotateRight(_ node: inout Node?)
}

public extension BinaryTreeRotation where Node: BinaryTreeNode {
    
    mutating func rotateLeft(_ node: inout Node?) {
        var right = node?.right
        node?.right = right?.left
        right?.left = node
        node = right
    }
    
    mutating func rotateRight(_ node: inout Node?) {
        var left = node?.left
        node?.left = left?.right
        left?.right = node
        node = left
    }
}
