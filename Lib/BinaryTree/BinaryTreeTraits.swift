//
//  BinaryTreeTraits.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 16.02.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import Foundation

public protocol BinaryTreeTraits {
    associatedtype Value

    var isEmpty: Bool { get }

    func search(value: Value) -> Bool

    mutating func insert(_ value: Value)

    @discardableResult
    mutating func remove(_ value: Value) -> Bool
}

public protocol BinaryTreeSerialOperations: BinaryTreeTraits {
    associatedtype Value

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
