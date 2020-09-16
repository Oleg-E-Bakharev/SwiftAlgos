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
        var prev = head
        setTail(head)
        var curr = prev?.next
        while curr != nil {
            let next = curr?.next
            curr?.next = prev
            prev = curr
            curr = next
        }
        setHead(prev)
        tail?.next = nil
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
        list.setTail(list.tail)
        repeat {
            guard let node = mergeStep(&left, &right) else {
                return list
            }
            list.tail?.next = node
            list.setTail(node)
        } while(true)
    }
}
