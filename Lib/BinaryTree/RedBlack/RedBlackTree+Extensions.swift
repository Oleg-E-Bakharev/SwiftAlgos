//
//  RedBlackTree+Extensions.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 31.07.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

extension RedBlackTree: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Value...) {
        for element in elements {
            insert(element)
        }
    }
}

extension RedBlackTree: ExpressibleByUnicodeScalarLiteral where Value == Character {
    public typealias UnicodeScalarLiteralType = Value
    public init(unicodeScalarLiteral value: Character) {
        insert(value)
    }
}

extension RedBlackTree: ExpressibleByExtendedGraphemeClusterLiteral where Value == Character {
    public typealias ExtendedGraphemeClusterLiteralType = Value
    public init(extendedGraphemeClusterLiteral value: Character) {
        insert(value)
    }
}

extension RedBlackTree: ExpressibleByStringLiteral where Value == Character {
    public typealias StringLiteralType = String
    public init(stringLiteral string: Self.StringLiteralType) {
        for character in string {
            insert(character)
        }
    }
}
