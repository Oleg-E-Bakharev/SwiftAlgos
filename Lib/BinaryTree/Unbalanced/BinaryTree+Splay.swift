//
//  BinaryTree+Splay.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 26.02.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import Foundation

public extension BinaryTree {
    mutating func splaySearch(_ value: T) -> Bool {
        Node.splay(Node.splayEquivalence, to: &root, value: value) != nil
    }

    mutating func splayInsert(_ value: T) {
        copyNodesIfNotUnique()
        Node.splay(Node.splayInsertion, to: &root, value: value)
    }

    @discardableResult
    mutating func splayRemove(_ value: T) -> Bool {
        copyNodesIfNotUnique()
        return Node.splay(Node.splayRemoving, to: &root, value: value) != nil
    }
}
