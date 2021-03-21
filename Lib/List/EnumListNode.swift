//
//  EnumListNode.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 02.03.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import Foundation

public enum EnumListNode<Value> {
    indirect case some(Value, Self)
    case empty

    public var next: Self {
        switch self {
        case .some(_, let next): return next
        case .empty: return self
        }
    }

    public var isEmpty: Bool {
        guard case .empty = self else { return false }
        return true
    }

    public mutating func push(_ value: Value) {
        self = .some(value, self)
    }

    public init(_ values: Value...) {
        self = values.reversed().reduce(.empty) {
            $0.cons($1)
        }
    }

    private func cons(_ value: Value) -> Self {
        .some(value, self)
    }
}

extension EnumListNode: CustomStringConvertible {
    public var description: String {
        var curr = self
        var result = ""
        while case let .some(value, next) = curr {
            result += "\(value)"
            if case .some(_, _) = next {
                result += "->"
            }
            curr = next
        }
        return result.isEmpty ? "<Empty>" : result
    }
}

public extension EnumListNode {
    func reversed() -> Self {
        guard case .some(let value, var curr) = self else { return self }
        var prev = Self.some(value, .empty)
        while case let .some(value, next) = curr {
            curr = .some(value, prev)
            prev = curr
            curr = next
        }
        return prev
    }

    /// On single node list returns self.
    func getMiddle() -> Self {
        guard case .some(_, var middle) = self, case .some(_, var tail) = middle else { return self }
        while case .some(_, let t) = tail {
            middle = middle.next
            tail = t.next.next
        }
        return middle
    }
}

extension EnumListNode: ExpressibleByArrayLiteral {
    public init(arrayLiteral values: Value...) {
        self = values.reversed().reduce(.empty) {
            $0.cons($1)
        }
    }
}

extension EnumListNode: Equatable where Value: Equatable {}
