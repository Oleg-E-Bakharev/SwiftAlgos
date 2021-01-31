//
//  Pointers.swift
//  SwiftAlgosLib
//
//  Created by Oleg Bakharev on 31.01.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import Foundation

public func bridge<T : AnyObject>(obj : T) -> UnsafeMutableRawPointer {
    return UnsafeMutableRawPointer(Unmanaged.passUnretained(obj).toOpaque())
}

public func bridge<T : AnyObject>(ptr : UnsafeRawPointer) -> T {
    return Unmanaged<T>.fromOpaque(ptr).takeUnretainedValue()
}

public func bridgeRetained<T : AnyObject>(obj : T) -> UnsafeMutableRawPointer {
    return UnsafeMutableRawPointer(Unmanaged.passRetained(obj).toOpaque())
}

public func bridgeTransfer<T : AnyObject>(ptr : UnsafeRawPointer) -> T {
    return Unmanaged<T>.fromOpaque(ptr).takeRetainedValue()
}

extension UnsafeMutableRawPointer {
    public static let empty = UnsafeMutableRawPointer.allocate(byteCount: 0, alignment: 0)
}
