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
        var list = List()
        list.setHead(head)
        list.setTail(tail)
        return list
    }
    
    mutating func halve() -> List? {
        var middle = 
    }
}

