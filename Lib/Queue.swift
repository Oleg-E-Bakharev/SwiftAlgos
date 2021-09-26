//
//  Queue.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 02.10.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import Foundation

public protocol Queue : ExpressibleByArrayLiteral {
    associatedtype Element

    var isEmpty: Bool { get }

    var count: Int { get }

    var peek: Element? { get }

    mutating func enqueue(_ element: Element)
    
    @discardableResult
    mutating func dequeue() -> Element?

    mutating func removeAll()
}
