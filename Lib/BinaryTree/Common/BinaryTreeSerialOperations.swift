//
//  BinaryTreeSerialOperations.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 31.07.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

public protocol BinaryTreeSerialOperations: BinaryTreeTraits {
    mutating func insert(_ pairs: [(Key, Value)])
    mutating func remove(_ keys: [Key])
}

public extension BinaryTreeSerialOperations {
    mutating func insert(_ pairs: [(Key, Value)]) {
        for (key, value) in pairs {
            insert(key: key, value: value)
        }
    }

    mutating func remove(_ keys: [Key]) {
        for key in keys {
            remove(key)
        }
    }
}

public extension BinaryTreeSerialOperations where Key == Value {
    mutating func insert(_ keys: [Key]) {
        for key in keys {
            insert(key: key, value: key)
        }
    }

    mutating func remove(_ keys: [Key]) {
        for key in keys {
            remove(key)
        }
    }
}
