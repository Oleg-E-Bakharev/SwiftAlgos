//
//  BlockAllocator.swift
//  SwiftAlgosSandbox
//
//  Created by Oleg Bakharev on 28.08.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

public final class BlockAllocator<T, Q: Queue>: AnyAllocator where Q.Element == Int {
    private var storage: [T] = []
    private var placeholders: Q = []
    #if DEBUG
    private var deletedPositions = Set<Int>()
    #endif

    public var count: Int { storage.count - placeholders.count }
    public var isEmpty: Bool { return count == 0 }

    public init() { }

    // O(1)
    public func allocate(for value: T) -> Int {
        if let index = placeholders.dequeue() {
            storage[index] = value
            #if DEBUG
            deletedPositions.remove(index)
            #endif

            return index
        }
        storage.append(value)
        return storage.count - 1
    }

    // O(1)
    public func deallocate(_ index: Int) {
        placeholders.enqueue(index)
        #if DEBUG
        deletedPositions.insert(index)
        #endif
    }

    public func removeAll() {
        storage.removeAll()
        placeholders.removeAll()
        #if DEBUG
        deletedPositions.removeAll()
        #endif
    }

    @inline(__always)
    public subscript(index: Int) -> T {
        get {
            #if DEBUG
            assert(!deletedPositions.contains(index))
            #endif
            return storage[index]
        }
        set {
            #if DEBUG
            assert(!deletedPositions.contains(index))
            #endif
            return storage[index] = newValue
        }
    }

    public func copy() -> BlockAllocator {
        let copy = BlockAllocator()
        copy.storage = storage
        copy.placeholders = placeholders
        return copy
    }
}

extension BlockAllocator: Codable where T: Codable, Q: Codable { }
