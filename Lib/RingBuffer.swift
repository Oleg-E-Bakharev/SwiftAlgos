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
    var storage: [Element?] = [nil] // Initial capacity must be 1
    var front: Int = 0
    var back: Int = 0
    
    /// O1
    public init() {}
        
    /// O1 average
    public mutating func pushFront(_ element: Element) {
        growIfNeed()
        storage[front] = element
        front = (front + 1) % storage.count
    }
    
    /// O1 average
    public mutating func pushBack(_ element: Element) {
        growIfNeed()
        back = (storage.count + back - 1) % storage.count
        storage[back] = element
    }
    
    /// O1
    @discardableResult
    public mutating func popFront() -> Element? {
        guard !isEmpty else { return nil }
        front = (storage.count + front - 1) % storage.count
        defer { storage[front] = nil }
        return storage[front]
    }
    
    @discardableResult
    public mutating func popBack() -> Element? {
        guard !isEmpty else { return nil }
        defer {
            storage[back] = nil
            back = (back + 1) % storage.count
        }
        return storage[back]
    }
    
    public var isEmpty: Bool { storage[back] == nil }

    /// On
    public mutating func reserveCapacity(_ amount: Int) {
        normalize()
        storage.reserveCapacity(amount)
        initialize()
    }
    
    private mutating func growIfNeed() {
        // If buffer fulfilled at full capacity then grow
        guard front == back && !isEmpty else { return }
        normalize()
        front = storage.count
        storage.reserveCapacity(storage.count * 2)
        initialize()
    }
    
    /// On
    private mutating func normalize() {
        if back != 0 {
            // Grouping content at begin of buffer
            storage.rotate(on: back)
            front = (storage.count + front - back) % storage.count
            back = 0
        }
    }
    
    private mutating func initialize() {
        // Fill free capacity with nil values
        assert(back == 0)
        if front == back {
            front = count % storage.capacity
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

// Sequence operations
extension RingBuffer {
    mutating func pushFront<S: Sequence>(sequence: S) where S.Element == Self.Element {
        for element in sequence {
            pushFront(element)
        }
    }

    mutating func pushBack<S: Sequence>(sequence: S) where S.Element == Self.Element {
        for element in sequence {
            pushBack(element)
        }
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
        let count = (storage.count + front - back) % storage.count
        // front == back can means that buffer is empty or full up to capacity.
        if count != 0 { return count }
        return isEmpty ? 0 : storage.count
    }
    
    private func index(_ item: Int) -> Int {
        (storage.count + back + item % storage.count) % storage.count
    }
    
    public subscript(_ item: Int) -> Element {
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
        reserveCapacity(count - range.count + newElements.count)
        let upperPart = Array(storage[range.upperBound..<count])
        for (index, element) in newElements.enumerated() {
            storage[index] = element
        }
        storage.append(contentsOf: upperPart)
        initialize()
    }
}
