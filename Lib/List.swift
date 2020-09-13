//
//  List.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 12.09.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import Foundation

public struct List<Value> {
    public typealias Node = ListNode<Value>
    
    // Marker for copy-on-write
    private class UniqueMarker {}
    private var uniqueMarker = UniqueMarker()
    
    public private(set) var head: Node?
    public private(set) var tail: Node?
    
    public init() {}
    
    public var isEmpty: Bool {
        head == nil
    }
    
    /// O1 Adds before head
    public mutating func push(_ value: Value)  {
        // On push we can avoid copy on write
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    /// O1 Adds after tail
    public mutating func append(_ value: Value) {
        copyNodesIfNotUnique()
        guard let tail = tail else {
            push(value)
            return
        }
        
        tail.next = Node(value: value)
        self.tail = tail.next
    }
    
    /// O1 Insert Value after Node
    @discardableResult
    public mutating func insert(_ value: Value, after node: Node) -> Node {
        copyNodesIfNotUnique()
        guard tail !== node else {
            append(value)
            return tail!
        }
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    
    /// O1 Remove Value in head.
    @discardableResult
    public mutating func pop() -> Value? {
        // On push we can avoid copy on write
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    /// O1 Remove Value afterNode
    @discardableResult
    public mutating func remove(after node: Node) -> Value? {
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }
    
    private mutating func copyNodesIfNotUnique() {
        guard !isKnownUniquelyReferenced(&uniqueMarker), var oldNode = head else {
            return
        }
        head = ListNode(value: oldNode.value)
        var newNode = head
        
        while let oldNodeNext = oldNode.next {
            newNode!.next = ListNode(value: oldNodeNext.value)
            oldNode = oldNodeNext
            newNode = newNode!.next
        }
        
        tail = newNode
    }
}

extension List: ExpressibleByArrayLiteral {
    public init(arrayLiteral values: Value...) {
        for value in values {
            append(value)
        }
    }
}

extension List: Sequence {
    public struct Iterator: IteratorProtocol {
        public var node: Node?
        public mutating func next() -> Value? {
            defer {
                node = node?.next
            }
            return node?.value
        }
    }
    
    public __consuming func makeIterator() -> Iterator {
        return Iterator(node: head)
    }
}

extension List: CustomStringConvertible {
    public var description: String {
        guard let head = head else {
            return "Empty list"
        }
        return "\(head)"
    }
}
