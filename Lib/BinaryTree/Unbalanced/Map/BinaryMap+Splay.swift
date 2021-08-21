//
//  BinaryMap+Splay.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 26.02.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import Foundation

public extension BinaryMap {
    mutating func splaySearch(_ key: Key) -> Value? {
        Node.splay(Node.splayEquivalence, to: &root, key: key)?.value
    }

    mutating func splayInsert(key: Key, value: Value) {
        copyNodesIfNotUnique()
        Node.splay(Node.splayInsertion, to: &root, key: key, newNode: .init(key: key, value: value))
    }

    @discardableResult
    mutating func splayRemove(_ key: Key) -> Bool {
        copyNodesIfNotUnique()
        return Node.splay(Node.splayRemoving, to: &root, key: key) != nil
    }

    subscript(splay key: Key) -> Value? {
        mutating get { splaySearch(key) }
        set {
            if let value = newValue { splayInsert(key: key, value: value) }
            else { splayRemove(key) }
        }
    }
}
