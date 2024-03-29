//
//  RedBlackSet+Codable.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 08.08.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

extension RedBlackSet: Decodable where Value: Decodable {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            let value = try container.decode(Value.self)
            insert(value)
        }
    }
}

extension RedBlackSet: Encodable where Value: Encodable { /* SequenceEx implemented */ }
