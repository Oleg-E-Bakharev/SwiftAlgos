//
//  ListAlgos.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 14.09.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import Foundation

public extension List {
    
    /// On
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
}
