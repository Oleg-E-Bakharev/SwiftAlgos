//
//  ListNode.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 12.09.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import Foundation

public class ListNode<Value> {
    public var value: Value
    public var next: ListNode?
    
    public init(value: Value, next: ListNode? = nil) {
        self.value = value
        self.next = next
    }
}

public extension ListNode {
    /// On-time O1-memory
    static func reverse(_ head: ListNode?) -> ListNode? {
        var prev = head
        var curr = prev?.next
        while curr != nil {
            let next = curr?.next
            curr?.next = prev
            prev = curr
            curr = next
        }
        head?.next = nil
        return prev
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
