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

    public mutating func removeAll() {
        storage = [nil]
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

extension RingBuffer: Codable where Element: Codable { }
