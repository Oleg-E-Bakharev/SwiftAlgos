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
    
    public init() {}
        
    public mutating func pushFront(_ element: Element) {
        growIfNeed()
        storage[front] = element
        front = (front + 1) % storage.count
    }
    
    public mutating func pushBack(_ element: Element) {
        growIfNeed()
        back = (storage.count + back - 1) % storage.count
        storage[back] = element
    }
    
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
    
    private mutating func growIfNeed() {
        guard front == back && !isEmpty else { return }
        if front != 0 {
            storage.rotate(on: front)
            back = 0
        }
        front = storage.count
        back = 0
        storage.reserveCapacity(storage.count * 2)
        storage.append(contentsOf: (0..<storage.count).map { _ in nil } )
    }
            
    public var isEmpty: Bool { storage[back] == nil }
}

extension RingBuffer: Sequence {
    public struct Iterator: IteratorProtocol {
        private let ringBuffer: RingBuffer
        private var current: Int
        
        public init(storage: RingBuffer) {
            self.ringBuffer = storage
            self.current = storage.back
        }
        
        public mutating func next() -> Element? {
            guard current != ringBuffer.storage.count + ringBuffer.back else {
                return nil
            }
            defer {
                current += 1
            }
            return ringBuffer.storage[current % ringBuffer.storage.count]
        }
    }
    
    __consuming public func makeIterator() -> Iterator {
        return Iterator(storage: self)
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
        return "[\(elements.joined(separator: ", "))]"
    }
}

//    public var count: Int {
//        let count = (storage.count + front - back) % storage.count
//        // front == back can means that buffer is empty or full up to capacity.
//        if count != 0 { return count }
//        return isEmpty ? 0 : storage.count
//    }
    
//    private func index(_ item: Int) -> Int {
//        (storage.count + back + item % storage.count) % storage.count
//    }
    
//    public subscript(_ item: Int) -> Element {
//        get {
//            storage[index(item)]!
//        }
//        set {
//            storage[index(item)] = newValue
//        }
//    }
//}
