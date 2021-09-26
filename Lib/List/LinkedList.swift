//
//  LinkedList.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 29.08.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

// Cannot move inside LinkedList via getting compiler error Illegal instruction: 4 on Swift 5.4.2
public struct LinkedListNode<Value> {
    var value: Value
    var next: Int
}

public struct LinkedList<Value, Allocator: AnyAllocator> where Allocator.Element == LinkedListNode<Value> {
    public typealias Node = LinkedListNode<Value>

    public struct Link: ListLink {
        unowned var allocator: Allocator
        let index: Int
        public var value: Value {
            get {
                allocator[index].value
            }
            set {
                allocator[index].value = newValue
            }
        }

        public var next: Link? {
            get {
                let nextIndex = allocator[index].next
                guard nextIndex != .none else { return nil }
                return Link(allocator: allocator, index: nextIndex)
            }
            set {
                allocator[index].next = newValue?.index ?? .none
            }
        }

        public static func == (lhs: Link, rhs: Link) -> Bool {
            lhs.index == rhs.index
        }
    }

    private var storage: Allocator

    private var headIndex = Int.none
    private var tailIndex = Int.none

    public var count: Int { storage.count }
    public var isEmpty: Bool { storage.isEmpty }

    public private(set) var head: Link? {
        get {
            headIndex == .none ? nil : Link(allocator: storage, index: headIndex)
        }
        set {
            assert(newValue == nil || storage === newValue!.allocator)
            headIndex = newValue?.index ?? .none
        }
    }

    public private(set) var tail: Link? {
        get {
            tailIndex == .none ? nil : Link(allocator: storage, index: tailIndex)
        }
        set {
            assert(newValue == nil || storage === newValue!.allocator)
            tailIndex = newValue?.index ?? .none
        }
    }

    // Marker for copy-on-write
    private class UniqueMarker {}
    private var uniqueMarker = UniqueMarker()

    public init(allocator: Allocator) {
        storage = allocator
    }

    public init(allocator: Allocator, _ values: Value...) {
        self.storage = allocator
        for value in values {
            append(value)
        }
    }

    /// O(1) Insert before head.
    public mutating func push(_ value: Value)  {
        // On push we can avoid copy on write
        let node = Node(value: value, next: headIndex)
        headIndex = storage.allocate(for: node)
        if tailIndex == .none {
            tailIndex = headIndex
        }
    }

    /// O(1) Adds after tail
    public mutating func append(_ value: Value) {
        copyNodesIfNotUnique()
        guard tailIndex != .none else {
            push(value)
            return
        }
        let node = Node(value: value, next: .none)
        let newTailIndex = storage.allocate(for: node)
        storage[tailIndex].next = newTailIndex
        tailIndex = newTailIndex
    }

    /// O(1) Insert Value after Node. If node not from list - result unpredictable
    public mutating func insert(_ value: Value, after link: Link) {
        let link = copyNodesIfNotUnique(link)!
        let index = link.index
        guard tailIndex != link.index else {
            append(value)
            return
        }
        let node = Node(value: value, next: storage[index].next)
        let newIndex = storage.allocate(for: node)
        storage[index].next = newIndex
    }

    /// O1 Remove Value in head.
    @discardableResult
    public mutating func pop() -> Value? {
        copyNodesIfNotUnique()
        guard !storage.isEmpty else { return nil }
        let value = storage[headIndex].value
        let index = headIndex
        headIndex = storage[headIndex].next
        storage.deallocate(index)
        if isEmpty {
            tailIndex = .none
        }
        return value
    }

    /// O1 Remove Value afterNode. If node not from list - result unpredictable
    @discardableResult
    public mutating func remove(after link: Link) -> Value? {
        let link = copyNodesIfNotUnique(link)!
        guard let next = link.next else { return nil }
        let index = link.index
        let value = storage[next.index].value
        storage[index].next = storage[next.index].next
        if next.index == tailIndex {
            tailIndex = link.index
        }
        storage.deallocate(next.index)
        return value
    }

    public mutating func removeAll() {
        copyNodesIfNotUnique()
        headIndex = .none
        tailIndex = .none
        storage.removeAll()
    }

    /// On time, O1 memory
    public mutating func reverse() {
        tail = head
        head = Link.reverse(head)
    }

    /// OnLogN-time O1-memory OlogN-stack(recursion)
    public mutating func sort(compare: (Value, Value)->Bool) {
        guard !isEmpty else { return }
        var head = self.head
        var tail = self.tail
        Link.sort(&head, &tail, compare: compare)
        self.head = head
        self.tail = tail
    }

    @discardableResult
    private mutating func copyNodesIfNotUnique(_ doublingNode: Link? = nil) -> Link? {
        guard !isKnownUniquelyReferenced(&uniqueMarker) else {
            return doublingNode
        }
        #if DEBUG
        print("*** \(#file) copy on write ***")
        #endif

        storage = storage.copy()

        guard let doublingNode = doublingNode else { return nil }
        let resultNode = Link(allocator: storage, index: doublingNode.index)
        return resultNode
    }
}

public extension LinkedList where Allocator == BlockAllocator<Node, RingBuffer<Int>> {
    init(_ empty: Value?)  {
        self.init(allocator: .init())
    }

    init(_ values: Value...) {
        self.storage = Allocator()
        for value in values {
            append(value)
        }
    }
}

extension LinkedList.Link: CustomStringConvertible {
    public var description: String {
        guard index != .none else {
            return "empty"
        }
        guard let next = next else {
            return "\(value)"
        }
        return "\(value) -> \(next)"
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return "\(head)"
    }
}

extension LinkedList: Sequence {
    public struct Iterator: IteratorProtocol {
        public var link: Link?
        public mutating func next() -> Value? {
            defer {
                link = link?.next
            }
            return link?.value
        }
    }

    public __consuming func makeIterator() -> Iterator {
        return Iterator(link: head)
    }
}

extension LinkedList: ExpressibleByArrayLiteral where Allocator == BlockAllocator<Node, RingBuffer<Int>>  {
    public init(arrayLiteral values: Value...) {
        self.storage = Allocator()
        for value in values {
            append(value)
        }
    }
}

extension LinkedList: Equatable where Value: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        if lhs.storage === rhs.storage {
            return
                lhs.headIndex == rhs.headIndex
                && lhs.tailIndex == rhs.tailIndex
        }

        var left: Link? = lhs.head
        var right: Link? = rhs.head
        while let l = left {
            guard let r = right, l.value == r.value else {
                return false
            }
            left = l.next
            right = r.next
        }
        return right == nil
    }
}

private extension Int {
    static var none = -1
}
