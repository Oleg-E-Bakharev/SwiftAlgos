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
    
    /// O1 Insert Value after Node. If node not from list - result unpredictable
    @discardableResult
    public mutating func insert(_ value: Value, after node: Node) -> Node {
        let node = copyNodesIfNotUnique(node)!
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
        // On pop we can avoid copy on write
        defer {
            head = head?.next
            if isEmpty {
                tail = nil
            }
        }
        return head?.value
    }
    
    /// O1 Remove Value afterNode. If node not from list - result unpredictable
    @discardableResult
    public mutating func remove(after node: Node) -> Value? {
        let node = copyNodesIfNotUnique(node)!
        defer {
            if node.next === tail {
                tail = node
            }
            node.next = node.next?.next
        }
        return node.next?.value
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

extension List: ExpressibleByArrayLiteral {
    public init(arrayLiteral values: Value...) {
        for value in values {
            append(value)
        }
    }
}

extension List: ExpressibleByUnicodeScalarLiteral where Value == Character {
    public typealias UnicodeScalarLiteralType = Value
    public init(unicodeScalarLiteral value: Character) {
        push(value)
    }
}

extension List: ExpressibleByExtendedGraphemeClusterLiteral where Value == Character {
    public typealias ExtendedGraphemeClusterLiteralType = Value
    public init(extendedGraphemeClusterLiteral value: Character) {
        push(value)
    }
}

extension List: ExpressibleByStringLiteral where Value == Character {
    public typealias StringLiteralType = String
    public init(stringLiteral string: Self.StringLiteralType) {
        for character in string {
            append(character)
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

extension List: Equatable where Value: Equatable {
    public static func == (lhs: List, rhs: List) -> Bool {
        lhs.head == rhs.head
    }
}
