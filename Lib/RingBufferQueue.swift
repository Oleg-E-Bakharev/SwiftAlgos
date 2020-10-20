//
//  RingBufferQueue.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 19.10.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import Foundation

extension RingBuffer: Queue {
    public mutating func enqueue(_ element: T) {
        pushFront(element)
    }
    
    @discardableResult
    public mutating func dequeue() -> T? {
        popBack()
    }
    
    public var peek: T? {
        last
    }
}
