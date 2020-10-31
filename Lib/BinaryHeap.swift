//
//  BinaryHeap.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 22.10.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import Foundation

struct BinaryHeap<T, P: Comparable> {
    typealias Item = (value: T, priority: P)
    private var storage: [Item] = []
//    private let compare: (T, T) -> Bool
    @inlinable public var count: Int { storage.count }
    
    /// O1
    public init(compare: @escaping (T, T) -> Bool) {
//        self.compare = compare
    }
    public init() {
//        self.compare = (<)
    }
    
    /// OlogN
    @inlinable public mutating func Push(value: T, priority: P) {
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
    
    @inline(__always) private func getLeftChild(_ i: Int) -> Int { (i << 1) + 1 }
    
    @inline(__always) private func getRightChild(_ i: Int) -> Int { (i << 1) + 2 }
    
    @inline(__always) private func getParent(_ i: Int) -> Int { (i - 1) >> 2 }
    
    private mutating func siftDown(_ index: Int) {
        var parent = index
        var left = getLeftChild(parent)
        while left < count {
            let right = getRightChild(parent)
            var child = left
            if right < count && storage[right].priority > storage[left].priority {
                child = right
            }
            if storage[parent].priority > storage[child].priority {
                break
            }
            storage.swapAt(parent, child)
            parent = child
            left = getLeftChild(parent)
        }
    }
    
    private mutating func siftUp(_ index: Int) {
        var child = index
        var parent = getParent(index)
        while parent >= 0 && storage[parent].priority < storage[child].priority {
            storage.swapAt(parent, child)
            child = parent
            parent = getParent(parent)
        }
    }
    
    private mutating func buildHeap() {
        for index in (0...(count / 2)) {
            siftDown(index)
        }
    }
    
    func checkValid(from index: Int = 0) -> Bool {
        guard index < count / 2 else { return true }
        let left = getLeftChild(index)
        let right = getRightChild(index)
        if storage[index].priority < Swift.max(storage[left].priority, storage[right].priority) {
            return false
        }
        return checkValid(from: left) && checkValid(from: right)
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
}

extension BinaryHeap: RandomAccessPriorityQueue {
    /// OlogN
    mutating func changePriority(of item: Int, to newPriority: P) {
        let prevPriority = storage[item].priority
        guard prevPriority != newPriority else { return }
        storage[item].priority = newPriority
        if newPriority > prevPriority {
            siftDown(item)
        } else {
            siftUp(item)
        }
    }
}

extension BinaryHeap: MutableCollection {}

extension BinaryHeap: Equatable where T: Equatable {
    internal static func == (lhs: BinaryHeap, rhs: BinaryHeap) -> Bool {
        lhs.count == rhs.count && (lhs.startIndex..<lhs.endIndex).allSatisfy { lhs[$0] == rhs[$0] }
    }
}

extension BinaryHeap: RangeReplaceableCollection {
    
}

extension BinaryHeap: ExpressibleByArrayLiteral {
    public init(arrayLiteral items: Item...) {
        reserveCapacity(count + items.count)
        for item in items {
            storage.append(item)
        }
        buildHeap()
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


