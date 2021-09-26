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
    public typealias Value = Value
    
    // Marker for copy-on-write
    private class UniqueMarker {}
    private var uniqueMarker = UniqueMarker()
    
    public private(set) var head: Node?
    public private(set) var tail: Node?
    public private(set) var count: Int = 0
    
    public init(head: Node? = nil, tail: Node? = nil) {
        self.head = head
        self.tail = tail
    }

    public init(_ values: Value...) {
        for value in values {
            append(value)
        }
    }

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
        count += 1
    }
    
    /// O1 Adds after tail
    public mutating func append(_ value: Value) {
        copyNodesIfNotUnique()
        guard let tail = tail else {
            push(value)
            return
        }
        count += 1
        tail.next = Node(value: value)
        self.tail = tail.next
    }
    
    /// O1 Insert Value after Node. If node not from list - result unpredictable
    @discardableResult
    public mutating func insert(_ value: Value, after node: Node) -> Node {
        let node = copyNodesIfNotUnique(node)!
        guard tail !== node else {
            append(value)
            return tail!
        }
        count += 1
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    
    /// O1 Remove Value in head.
    @discardableResult
    public mutating func pop() -> Value? {
        // On pop we can avoid copy on write
        defer {
            head = head?.next
            count -= 1
            if isEmpty {
                tail = nil
                count = 0
            }
        }
        return head?.value
    }
    
    /// O1 Remove Value afterNode. If node not from list - result unpredictable
    @discardableResult
    public mutating func remove(after node: Node) -> Value? {
        let node = copyNodesIfNotUnique(node)!
        defer {
            count -= 1
            if node.next === tail {
                tail = node
                count = 0
            }
            node.next = node.next?.next
        }
        return node.next?.value
    }

    public mutating func removeAll() {
        head = nil
        tail = nil
        count = 0
    }

    @discardableResult
    private mutating func copyNodesIfNotUnique(_ doublingNode: Node? = nil) -> Node? {
        guard !isKnownUniquelyReferenced(&uniqueMarker), var oldNode = head else {
            return doublingNode
        }
        #if DEBUG
        print("*** \(#file) copy on write ***")
        #endif
        
        head = ListNode(value: oldNode.value)
        var newNode = head
        var resultNode = newNode
        
        while let oldNodeNext = oldNode.next {
            newNode!.next = ListNode(value: oldNodeNext.value)
            oldNode = oldNodeNext
            newNode = newNode!.next
            if oldNode === doublingNode {
                resultNode = newNode
            }
        }
        
        tail = newNode
        return resultNode
    }
    
    internal mutating func setHead(_ head: Node?) {
        self.head = head
    }
    
    internal mutating func setTail(_ tail: Node?) {
        self.tail = tail
    }
}
