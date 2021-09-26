//
//  Deque.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 02.10.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import Foundation

public protocol Deque {
    associatedtype Element
    mutating func pushFront(_ element: Element)
    mutating func popFront() -> Element?
    mutating func pushBack(_ element: Element)
    mutating func popBack() -> Element?
    var isEmpty: Bool { get }
    var count: Int { get }
    var front: Element? { get }
    var back: Element? { get }
}
