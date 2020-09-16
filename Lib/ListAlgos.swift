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
        setHead(ListNode.reverse(head))
    }
    
    /// On-time O1-memory. Destructive merge sorted lists inplace
    static func mergeSorted(lhs: inout List, rhs: inout List, compare: (Value, Value)->Bool) -> List {
        var list = List()
        
        func mergeStep(_ left: inout Node?, _ right: inout Node?) -> Node? {
            guard left != nil && right != nil else { return nil }
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

        var right = rhs.head
        var left = lhs.head
        
        list.setHead(mergeStep(&left, &right))
        list.setTail(list.head)
        while(true) {
            guard let node = mergeStep(&left, &right) else { break }
            list.tail?.next = node
            list.setTail(node)
        }
        return list
    }
}
