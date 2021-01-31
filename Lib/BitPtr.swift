//
//  BitPtr.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 06.01.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import Foundation

/// Tagged pointer with one bit of storing information.
public class BitPtr<Target: AnyObject> {
    var ptr: UnsafeMutableRawPointer

    private func withCleanPtr<T>(closure: ()->T) -> T {
        let bit: Int
        if Int(bitPattern: ptr) & 1 > 0 {
            ptr -= 1
            bit = 1
        } else {
            bit = 0
        }
        defer { ptr += bit }
        return closure()
    }

    private func releasePtr() {
        if ptr != .empty {
            Unmanaged<Target>.fromOpaque(ptr).release()
        }
    }

    public var target: Target? {
        get {
            withCleanPtr {
                return ptr != .empty ? bridge(ptr: ptr) : nil
            }
        }

        set {
            withCleanPtr {
                releasePtr()
                if let newValue = newValue {
                    ptr = bridgeRetained(obj: newValue)
                } else {
                    ptr = .empty
                }
            }
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

    deinit {
        releasePtr()
    }
}
