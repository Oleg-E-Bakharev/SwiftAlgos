//
//  BinaryHeap.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 22.10.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import Foundation

public struct BinaryHeap<T, P: Comparable> {
    public typealias Item = (value: T, priority: P)
    var storage: [Item] = []
    let compare: (P, P) -> Bool
    public var count: Int { storage.count }
    
    /// O1
    public init(compare: @escaping (P, P) -> Bool) {
        self.compare = compare
    }
    
    public init() {
        self.compare = (>)
    }
    
    /// OlogN
    @inlinable public mutating func push(value: T, priority: P) {
        push((value: value, priority: priority))
    }

    /// OlogN
    public mutating func push(_ item: Item) {
        storage.append(item)
        siftUp(count - 1)
    }

    /// OlogN
    @discardableResult
    public mutating func pop() -> T? {
        guard count > 0 else { return nil }
        defer {
            storage.swapAt(0, count - 1)
            storage.removeLast()
            siftDown(0)
        }
        return storage.first?.value
    }
    
    /// O1
    public mutating func peek() -> T? {
        storage.first?.value
    }
    
    /// O1
    public func getPriority(of item: Int) -> P { storage[item].priority }
    
    @inline(__always) func getLeftChild(_ i: Int) -> Int { (i << 1) + 1 }
    
    @inline(__always) func getRightChild(_ i: Int) -> Int { (i << 1) + 2 }
    
    @inline(__always) func getParent(_ i: Int) -> Int { (i - 1) >> 2 }
    
    private mutating func siftDown(_ index: Int) {
        var parent = index
        var left = getLeftChild(parent)
        while left < count {
            let right = getRightChild(parent)
            var child = left
            if right < count && compare(storage[right].priority, storage[left].priority) {
                child = right
            }
            if self.compare(storage[parent].priority, storage[child].priority) {
                break
            }
            storage.swapAt(parent, child)
            parent = child
            left = getLeftChild(parent)
        }
    }
    
    // Ologn
    private mutating func siftUp(_ index: Int) {
        var child = index
        var parent = getParent(index)
        while parent >= 0 && compare(storage[child].priority, storage[parent].priority) {
            storage.swapAt(parent, child)
            child = parent
            parent = getParent(parent)
        }
    }
    
    // On
    private mutating func buildHeap() {
        for index in (0...count / 2).reversed() {
            siftDown(index)
        }
    }
}

extension BinaryHeap: RandomAccessCollection {
    public var startIndex: Int { 0 }
        
    public var endIndex: Int { count }
        
    public subscript(_ item: Int) -> T {
        get {
            storage[item].value
        }
        set {
            storage[item].value = newValue
        }
    }
    
    public mutating func reserveCapacity(_ capacity: Int) {
        storage.reserveCapacity(capacity)
    }
}

extension BinaryHeap: RandomAccessPriorityQueue {
    /// OlogN
    mutating func changePriority(of item: Int, to newPriority: P) {
        let prevPriority = storage[item].priority
        guard prevPriority != newPriority else { return }
        storage[item].priority = newPriority
        if compare(newPriority, prevPriority) {
            siftUp(item)
        } else {
            siftDown(item)
        }
    }
}

extension BinaryHeap: ExpressibleByArrayLiteral {
    public init(items: [Item], compare: @escaping (P, P) -> Bool) {
        self.compare = compare
        reserveCapacity(count + items.count)
        for item in items {
            storage.append(item)
        }
        buildHeap()
    }
    
    public init(arrayLiteral items: Item...) {
        self.init(items: items, compare: >)
    }
}

extension BinaryHeap: CustomStringConvertible {
    public var description: String {
        var elements: [String] = []
        for element in self {
            elements.append("\(element)")
        }
        let string =  "[\(elements.joined(separator: ", "))]"
        return string
    }
}


