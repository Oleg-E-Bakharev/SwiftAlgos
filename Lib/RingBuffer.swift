//
//  RingBuffer.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 02.10.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import Foundation

public struct RingBuffer<T> {
    public typealias Element = T
    var storage: [T?] = [nil] // Initial capacity must be 1
    var first: Int = 0
    var last: Int = 0
    
    /// O1
    public init() {}
        
    /// O1 average
    public mutating func pushFront(_ element: T) {
        growIfNeed()
        storage[first] = element
        first = (first + 1) % storage.count
    }
    
    public var front: T? {
        storage[(storage.count + first - 1) % storage.count]
    }
    
    public var back: T? {
        storage[last]
    }
        
    /// O1 average
    public mutating func pushBack(_ element: T) {
        growIfNeed()
        last = (storage.count + last - 1) % storage.count
        storage[last] = element
    }
    
    /// O1
    @discardableResult
    public mutating func popFront() -> T? {
        guard !isEmpty else { return nil }
        first = (storage.count + first - 1) % storage.count
        defer { storage[first] = nil }
        return storage[first]
    }
    
    @discardableResult
    public mutating func popBack() -> T? {
        guard !isEmpty else { return nil }
        defer {
            storage[last] = nil
            last = (last + 1) % storage.count
        }
        return storage[last]
    }
    
    public var isEmpty: Bool { storage[last] == nil }

    /// On
    public mutating func reserveCapacity(_ amount: Int) {
        normalize()
        storage.reserveCapacity(amount)
        initialize()
    }
    
    private mutating func growIfNeed() {
        // If buffer fulfilled at full capacity then grow
        guard first == last && !isEmpty else { return }
        normalize()
        first = storage.count
        storage.reserveCapacity(storage.count * 2)
        initialize()
    }
    
    /// On
    private mutating func normalize() {
        if last != 0 {
            // Grouping content at begin of buffer
            storage.rotate(on: last)
            first = (storage.count + first - last) % storage.count
            last = 0
        }
    }
    
    private mutating func initialize() {
        // Fill free capacity with nil values
        assert(last == 0)
        if first == last {
            first = count % storage.capacity
        }
        storage.append(contentsOf: (0..<storage.capacity - storage.count).map { _ in nil } )
    }
}

extension RingBuffer: ExpressibleByArrayLiteral {
    public init(arrayLiteral values: Element...) {
        reserveCapacity(count + values.count)
        for value in values {
            pushFront(value)
        }
    }
}

extension RingBuffer: Equatable where T: Equatable {
    public static func == (lhs: RingBuffer, rhs: RingBuffer) -> Bool  {
        lhs.count == rhs.count && (lhs.startIndex..<lhs.endIndex).allSatisfy { lhs[$0] == rhs[$0] }
    }
}

// Sequence & collection operations
extension RingBuffer {
    mutating func pushFront<S: Sequence>(sequence: S) where S.Element == Self.Element {
        for element in sequence {
            pushFront(element)
        }
    }

    mutating func pushBack<S: Sequence>(sequence: S) where S.Element == Self.Element {
        for element in sequence.reversed() {
            pushBack(element)
        }
    }
    
    mutating func pushFront<C: Collection>(collection: C) where C.Element == Self.Element {
        let count = self.count
        replaceSubrange(count..<count, with: collection)
    }

    mutating func pushBack<C: Collection>(collection: C) where C.Element == Self.Element {
        replaceSubrange(0..<0, with: collection)
    }

}

extension RingBuffer: CustomStringConvertible {
    public var description: String {
        var elements: [String] = []
        for element in self {
            elements.append("\(element)")
        }
        let string =  "[\(elements.joined(separator: ", "))]"
        return string
    }
}

extension RingBuffer: RandomAccessCollection {
    public var startIndex: Int { 0 }
    
    public var endIndex: Int { count }
            
    public var count: Int {
        let count = (storage.count + first - last) % storage.count
        // front == back can means that buffer is empty or full up to capacity.
        if count != 0 { return count }
        return isEmpty ? 0 : storage.count
    }
    
    private func index(_ item: Int) -> Int {
        let count = storage.count
        return (count + last + item % count) % count
    }
    
    public subscript(_ item: Int) -> T {
        get {
            storage[index(item)]!
        }
        set {
            storage[index(item)] = newValue
        }
    }
}

extension RingBuffer: MutableCollection {}

extension RingBuffer: RangeReplaceableCollection {
    
    /// O(range) if range.count == newElements.count. O(n + newElements.count) otherwise
    /// O(1) memory average
    mutating public func replaceSubrange<C, R>(_ subrange: R, with newElements: C) where C : Collection, R : RangeExpression, Self.Element == C.Element, Self.Index == R.Bound {
        let range = subrange.relative(to: self)
        if range.count == newElements.count {
            var i = range.lowerBound
            for element in newElements {
                self[i] = element
                i += 1
            }
            return
        }
        
        let lowerBound = range.lowerBound
        let prevCount = count
        let nextCount = prevCount - range.count + newElements.count

        reserveCapacity(nextCount)
        
        // First Alternative
        if nextCount >= prevCount {
            storage.rotateSubrange(range.upperBound..<nextCount, on: prevCount)
        } else {
            let from = lowerBound + newElements.count
            let on = newElements.count > 0 ? prevCount - newElements.count + 1 : prevCount - 1
            rotateSubrange(from..<prevCount, on: on)
            for i in nextCount..<storage.count {
                storage[i] = nil
            }
        }
        for (index, element) in newElements.enumerated() {
            storage[lowerBound + index] = element
        }

//        // SECOND Alternative
//        let upperPart = Array(storage[range.upperBound..<prevCount])
//        for (index, element) in newElements.enumerated() {
//            storage[lowerBound + index] = element
//        }
//        let remainsLowerBound = range.lowerBound + newElements.count
//        for (index, element) in upperPart.enumerated() {
//            storage[remainsLowerBound + index] = element
//        }
//        for i in nextCount..<storage.count {
//            storage[i] = nil
//        }

        first = nextCount % storage.count
    }
}

extension RingBuffer: Deque { }
