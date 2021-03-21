//
//  ListNode.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 12.09.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import Foundation

public final class ListNode<Value> {
    public var value: Value
    public var next: ListNode?

    public init(value: Value, next: ListNode? = nil) {
        self.value = value
        self.next = next
    }

    public func push(_ value: Value) -> Self {
        .init(value: value, next: self)
    }
}

public extension ListNode {
    /// On-time O1-memory
    static func reverse(_ head: ListNode?) -> ListNode? {
        var prev = head
        var curr = prev?.next
        prev?.next = nil
        while curr != nil {
            let next = curr?.next
            curr?.next = prev
            prev = curr
            curr = next
        }
        return prev
    }
    
    /// On+m. On exit head in left. tail in right.
    static func mergeSorted(_ left: inout ListNode?, _ right: inout ListNode?, compare: (Value, Value)->Bool) {
        func mergeStep(_ left: inout ListNode?, _ right: inout ListNode?) -> ListNode? {
            guard left != nil || right != nil else { return nil }
            guard let someLeft = left else {
                defer { right = right?.next }
                return right
            }
            guard let someRight = right else {
                defer { left = left?.next }
                return left
            }
            
            if compare(someLeft.value, someRight.value) {
                defer { left = left?.next }
                return left
            }
            defer { right = right?.next }
            return right
        }
        
        let head = mergeStep(&left, &right)
        var current = head
        while(true) {
            guard let node = mergeStep(&left, &right) else { break }
            current?.next = node
            current = node
        }
        left = head
        right = current
    }
    
    /// On On single node list returns self.
    func getMiddle() -> ListNode? {
        var tail = next?.next
        var middle: ListNode? = self
        while tail != nil {
            middle = middle?.next
            tail = tail?.next?.next
        }
        return middle
    }
}

extension ListNode: CustomStringConvertible {
    public var description: String {
        guard let next = next else {
            return "\(value)"
        }
        return "\(value) -> \(next)"
    }
}

extension ListNode: ExpressibleByArrayLiteral {
    public convenience init(arrayLiteral elements: Value...) {
        assert(elements.count > 0)
        var current: Self!
        elements.reversed().forEach {
            current = .init(value: $0, next: current)
        }
        self.init(value: current.value, next: current.next)
    }
}

extension ListNode: Equatable where Value: Equatable {
    public static func == (lhs: ListNode, rhs: ListNode) -> Bool {
        var left: ListNode? = lhs
        var right: ListNode? = rhs
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
