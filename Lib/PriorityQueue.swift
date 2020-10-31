//
//  PriorityQueue.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 22.10.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import Foundation

protocol PriorityQueue {
    associatedtype Element
    associatedtype Priority: Comparable
        
    mutating func push(value: Element, priority: Priority)
    
    @discardableResult
    mutating func pop() -> Element?
    
    mutating func peek() -> Element?
    
    mutating func reserveCapacity(_ minimumCapacity: Int)
}

protocol RandomAccessPriorityQueue: PriorityQueue, RandomAccessCollection {
    mutating func changePriority(of item: Int, to newPriority: Priority)
}
