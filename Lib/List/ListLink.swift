//
//  ListLink.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 29.08.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

public protocol ListLink: Equatable {
    associatedtype Value
    var value: Value { get set }
    var next: Self? { get set }
}

//public struct ListLink<Value, Link: ListLink> where Link.Node == Self, Link.Value == Value {
////    public var value: Value
//    public var next: Link?
//
//    public init(value: Value, next: Link? = nil) {
//        self.value = value
//        self.next = next
//    }
//
//    public func push(_ value: Value, link: inout Link) -> Self {
//        link.node = self
//        .init(value: value, next: Link(self))
//    }
//}

public extension ListLink {
    /// On-time O1-memory
    static func reverse(_ head: Self?) -> Self? {
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
    static func mergeSorted(_ left: inout Self?, _ right: inout Self?, compare: (Value, Value) -> Bool) {
        func mergeStep(_ left: inout Self?, _ right: inout Self?) -> Self? {
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
    func getMiddle() -> Self? {
        var tail = next?.next
        var middle: Self? = self
        while tail != nil {
            middle = middle?.next
            tail = tail?.next?.next
        }
        return middle
    }

    static func halve(_ head: Self?) -> (Self?, Self?) {
        var middle = head?.getMiddle()
        defer {
            middle?.next = nil
        }
        return (middle, middle?.next)
    }

    /// O(NLogN). On exit head in left. tail in right.
    static func sort(_ left: inout Self?, _ right: inout Self?, compare: (Value, Value) -> Bool) {
        guard left != right else { return }
        var (leftTail, rightHead) = halve(left)
        sort(&left, &leftTail, compare: compare)
        sort(&rightHead, &right, compare: compare)
        mergeSorted(&left, &rightHead, compare: compare)
        right = rightHead
    }
}

//extension ListLink: ExpressibleByArrayLiteral {
//    public convenience init(arrayLiteral elements: Value...) {
//        assert(elements.count > 0)
//        var current: Self!
//        elements.reversed().forEach {
//            current = .init(value: $0, next: current)
//        }
//        self.init(value: current.value, next: current.next)
//    }
//}

//extension ListLink: Equatable where Value: Equatable {
//    public static func == (lhs: ListLink, rhs: ListLink) -> Bool {
//        var left: ListLink? = lhs
//        var right: ListLink? = rhs
//        while let l = left {
//            guard let r = right, l.value == r.value else {
//                return false
//            }
//            left = l.next
//            right = r.next
//        }
//        return right == nil
//    }
//}
