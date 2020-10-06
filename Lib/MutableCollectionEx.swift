//
//  MutableCollectionEx.swift
//  SwiftAlgos
//
//  Created by Oleg Bakharev on 06.10.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import Foundation

public extension MutableCollection {
    /// On
    @inlinable mutating func reverse(from: Index, to: Index) {
        let last = index(to, offsetBy: -1)
        let count = distance(from: from, to: to) / 2
        for i in 0..<count {
            swapAt(index(from, offsetBy:i), index(last, offsetBy: -i))
        }
    }
    
    /// On
    @inlinable mutating func rotate(on index: Index) {
        reverse(from: startIndex, to: index)
        reverse(from: index, to: endIndex)
        reverse(from: startIndex, to: endIndex)
    }
}
