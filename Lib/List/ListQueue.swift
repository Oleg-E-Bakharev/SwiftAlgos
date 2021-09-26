//
//  ListQueue.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 19.10.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import Foundation

extension List: Queue {
    public typealias Element = Value

    public var peek: Element? { head?.value }

    public mutating func enqueue(_ element: Element) {
        append(element)
    }
    
    @discardableResult
    public mutating func dequeue() -> Element? {
        pop()
    }
}
