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
    
    public mutating func popFront(_ element: Element) -> Element? {
        guard !isEmpty else { return nil }
        front = (storage.count + front - 1) % storage.count
        defer { storage[front] = nil }
        return storage[front]
    }
    
    public mutating func popBack(_ element: Element) -> Element? {
        guard !isEmpty else { return nil }
        defer {
            storage[back] = nil
            back = (back + 1) % storage.count
        }
        return storage[back]
    }
    
    private mutating func growIfNeed() {
        guard front != back && !isEmpty else { return }
        if front != 0 {
            // rotate buffer to back == 0
            reverseBufferFragment(from: 0, to: front)
            reverseBufferFragment(from: front, to: storage.count)
            reverseBufferFragment(from: 0, to: storage.count)
            back = 0
            front = storage.count
        }
        storage.reserveCapacity(storage.count * 2)
        storage.append(contentsOf: (0..<storage.count).map { _ in nil } )
    }
    
    private mutating func reverseBufferFragment(from: Int, to: Int) {
        for i in from..<to/2 {
            storage.swapAt(i, to - i)
        }
    }
    
    public var isEmpty: Bool { storage[back] == nil }
    
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
}
