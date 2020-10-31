//
//  MutableCollectionEx.swift
//  SwiftAlgos
//
//  Created by Oleg Bakharev on 06.10.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import Foundation

public extension Collection {
    /// O1 for RandomAccessCollection. On otherwise
    @inlinable subscript(safe index: Index) -> Element? {
        startIndex..<endIndex ~= index ? self[index] : nil
    }
}

public extension MutableCollection {
    
    /// O1 for RandomAccessCollection. On otherwise
    @inlinable subscript(safe index: Index) -> Element? {
        get {
            startIndex..<endIndex ~= index ? self[index] : nil
        }
        set {
            if startIndex..<endIndex ~= index, let newValue = newValue { self[index] = newValue }
        }
    }

    /// On
    @inlinable mutating func reverseSubrange<R: RangeExpression>(_ subrange: R) where Self.Index == R.Bound {
        let range = subrange.relative(to: self)
        let from = range.lowerBound
        let to = range.upperBound
        let last = index(to, offsetBy: -1)
        let count = distance(from: from, to: to) / 2
        for i in 0..<count {
            swapAt(index(from, offsetBy:i), index(last, offsetBy: -i))
        }
    }
    
    /// On. Element at index becomes first in collection
    @inlinable mutating func rotate(on index: Index) {
        rotateSubrange(startIndex..<endIndex, on: index)
    }
    
    /// On Element at index becomes first in subrange
    @inlinable mutating func rotateSubrange<R: RangeExpression>(_ subrange: R, on index: Index) where Self.Index == R.Bound {
        let range = subrange.relative(to: self)
        let from = range.lowerBound
        let to = range.upperBound
        reverseSubrange(from..<index)
        reverseSubrange(index..<to)
        reverseSubrange(from..<to)
    }
}
