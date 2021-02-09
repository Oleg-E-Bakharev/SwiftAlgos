//
//  BitPtr.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 06.01.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import Foundation

/**
 Tagged smart pointer with one bit of storing information.
 Please DO NOT use assigment operator like bitPtr1 = bitPtr2
 USE ~= operator instead like bitPtr1 ~= bitPtr2
 */

public struct BitPtr<Target: AnyObject> {
    var ptr: UnsafeMutableRawPointer

    public var target: Target? {
        get {
            let delta = bit ? 1 : 0
            let cleanPtr = ptr - delta
            return cleanPtr != .empty ? bridge(ptr: cleanPtr) : nil
        }

        set {
            let delta = bit ? 1 : 0
            let cleanPtr = ptr - delta
            release(ptr: cleanPtr)
            if let newValue = newValue {
                ptr = bridgeRetained(obj: newValue)
            } else {
                ptr = .empty
            }
            ptr += delta
        }
    }

    public var bit: Bool {
        get {
            Int(bitPattern: ptr) & 1 > 0
        }

        set {
            if Int(bitPattern: ptr) & 1 > 0 {
                if !newValue {
                    ptr -= 1
                }
            } else if newValue {
                ptr += 1
            }
        }
    }

    public init(_ target: Target? = nil, bit: Bool = false) {
        if let target = target {
            ptr = bridgeRetained(obj: target)
        } else {
            ptr = .empty
        }
        self.bit = bit
    }

    private func release(ptr: UnsafeMutableRawPointer) {
        if ptr != .empty {
            Unmanaged<Target>.fromOpaque(ptr).release()
        }
    }

    @inline(__always)
    static func ~=(lhs: inout BitPtr, rhs: Target?) {
        lhs.target = rhs
    }

    @inline(__always)
    static func ~=(lhs: inout BitPtr, rhs: BitPtr) {
        lhs.target = rhs.target
        lhs.bit = rhs.bit
    }
}

extension BitPtr: Equatable {}
