//
//  ListAlgos.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 14.09.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

public extension List {
    /// On time, O1 memory
    mutating func reverse() {
        setTail(head)
        setHead(Node.reverse(head))
    }
    
    /// On+m time, O1 memory. Merge with sorted list inplace
    mutating func mergeSorted(_ list: inout List, compare: (Value, Value)->Bool) {
        var head = self.head
        var tail = list.head
        ListNode<List.Value>.mergeSorted(&head, &tail, compare: compare)
        setHead(head)
        setTail(tail)
        list.setHead(nil)
        list.setTail(nil)
    }
    
    /// On  time, O1 memory
    mutating func halve() -> List {
        let middle = head?.getMiddle()
        defer {
            middle?.next = nil
            setTail(middle)
        }
        return List(head: middle?.next, tail: tail)
    }
    
    /// OnLogN-time O1-memory OlogN-stack(recursion)
    mutating func sort(compare: (Value, Value)->Bool) {
        guard tail !== head else { return }
        var second = halve()
        sort(compare: compare)
        second.sort(compare: compare)
        mergeSorted(&second, compare: compare)
    }
}

