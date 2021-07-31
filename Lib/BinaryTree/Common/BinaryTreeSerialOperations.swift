//
//  BinaryTreeSerialOperations.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 31.07.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

public protocol BinaryTreeSerialOperations: BinaryTreeTraits {
    mutating func insert(_ values: [Value])
    mutating func remove(_ values: [Value])
}

public extension BinaryTreeSerialOperations {
    mutating func insert(_ values: [Value]) {
        for value in values {
            insert(value)
        }
    }

    mutating func remove(_ values: [Value]) {
        for value in values {
            remove(value)
        }
    }
}
