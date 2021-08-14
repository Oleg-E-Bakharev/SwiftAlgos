//
//  BinarySet+Splay.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 26.02.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import Foundation

public extension BinarySet {
    mutating func splaySearch(_ key: T) -> Bool {
        Node.splay(Node.splayEquivalence, to: &root, key: key, newNode: nil) != nil
    }

    mutating func splayInsert(_ value: T) {
        copyNodesIfNotUnique()
        Node.splay(Node.splayInsertion, to: &root, key: value, newNode: .init(value))
    }

    @discardableResult
    mutating func splayRemove(_ key: T) -> Bool {
        copyNodesIfNotUnique()
        return Node.splay(Node.splayRemoving, to: &root, key: key, newNode: nil) != nil
    }
}
