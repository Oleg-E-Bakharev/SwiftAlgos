//
//  ListAlgos.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 14.09.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import Foundation

public extension List {
    
    /// On-time O1-memory
    mutating func reverse() {
        setTail(head)
        setHead(Node.reverse(head))
    }
    
    /// On+m time O1-memory. Destructive merge sorted lists inplace
    static func mergeSorted(_ left: inout List, _ right: inout List, compare: (Value, Value)->Bool) -> List {
        var head = left.head
        var tail = right.head
        ListNode<List.Value>.mergeSorted(&head, &tail, compare: compare)
        return List(head: head, tail: tail)
    }
    
    /// On
    mutating func halve() -> List {
        let middle = head?.getMiddle()
        defer {
            middle?.next = nil
            setTail(middle)
        }
        return List(head: middle?.next, tail: tail)
    }
}

