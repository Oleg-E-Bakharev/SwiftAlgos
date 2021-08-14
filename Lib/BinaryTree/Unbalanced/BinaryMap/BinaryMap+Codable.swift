//
//  BinaryMap+Codable.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 27.03.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

extension BinaryMap.Node {
    enum CodingKeys: String, CodingKey {
        case key
        case value
    }
}

extension BinaryMap.Node: Decodable where Key: Decodable, Value: Decodable {
    public convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let key = try container.decode(Key.self, forKey: .key)
        let value = try container.decode(Value.self, forKey: .value)
        self.init(key: key, value: value)
    }
}

extension BinaryMap.Node: Encodable where Key: Encodable, Value: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(key, forKey: .key)
        try container.encode(value, forKey: .value)
    }
}

extension BinaryMap: Decodable where Key: Decodable, Value: Decodable {
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd {
            let node = try container.decode(Node.self)
            insert(key: node.key, value: node.value)
        }
    }
}

extension BinaryMap: Encodable where Key: Encodable, Value: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        for (key, value) in self {
            let node = Node(key: key, value: value)
            try container.encode(node)
        }
    }
}
