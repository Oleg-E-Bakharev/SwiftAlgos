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
    
    public private(set) var head: Node?
    public private(set) var tail: Node?
    
    public init() {}
    
    public var isEmpty: Bool {
        head == nil
    }
    
    /// O1 Adds before head
    public mutating func push(_ value: Value)  {
        head = Node(value: value, next: head)
        if tail == nil {
            tail = head
        }
    }
    
    /// O1 Adds after tail
    public mutating func append(_ value: Value) {
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
}

extension List: ExpressibleByArrayLiteral {
    public init(arrayLiteral values: Value...) {
        for value in values {
            append(value)
        }
    }
}

extension List: Collection {
    
    public struct Index: Comparable {
        public var node: Node?
        
        public static func == (lhs: Index, rhs: Index) -> Bool {
            switch (lhs.node, rhs.node) {
            case let (left?, right?):
                return left === right
            case (nil, nil):
                return true
            default:
                return false
            }
        }
        
        public static func < (lhs: Index, rhs: Index) -> Bool {
            fatalError("unsupported")
//            print("<")
            guard lhs != rhs else {
                return false
            }
            let nodes = sequence(first: lhs.node) { $0?.next }
            return nodes.contains {$0 === rhs.node }
        }
    }
    
    public var startIndex: Index {
        Index(node: head)
    }
    
    public var endIndex: Index {
        Index(node: tail?.next)
    }
    
    public func index(after i: Index) -> Index {
        Index(node: i.node?.next)
    }
    
    public subscript(position: Index) -> Value {
        position.node!.value
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
