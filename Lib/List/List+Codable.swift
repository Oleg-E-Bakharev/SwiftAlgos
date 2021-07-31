//
//  List+Codable.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 27.03.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import Foundation

extension List: Decodable where Value: Decodable {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            let value = try container.decode(Value.self)
            append(value)
        }
    }
}

extension List: Encodable where Value: Encodable { /* SequenceEx implemented */ }
