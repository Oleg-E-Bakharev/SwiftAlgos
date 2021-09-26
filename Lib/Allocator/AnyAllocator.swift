//
//  Allocator.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 29.08.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

public protocol AnyAllocator: AnyObject {
    associatedtype Element

    var isEmpty: Bool { get }

    var count: Int { get }

    func allocate(for value: Element) -> Int

    func deallocate(_ item: Int)

    func removeAll()

    func copy() -> Self

    @inlinable subscript(index: Int) -> Element { get set }
}
