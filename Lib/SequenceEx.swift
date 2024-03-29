//
//  SequenceEx.swift
//  SeiftAlgosLib
//
//  Created by Oleg Bakharev on 27.03.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import Foundation

public extension Sequence where Element: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(contentsOf: self)
    }
}
