//
//  PointerExTests.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 31.01.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class PointerExTests: XCTestCase {

    var ptr: UnsafeMutableRawPointer = .empty

    override func setUpWithError() throws {
        ptr = bridgeRetained(obj: NSObject())
    }

    override func tearDownWithError() throws {
        Unmanaged<NSObject>.fromOpaque(ptr).release()
        ptr = .empty
    }

    func testBridge() {
        let obj: NSObject = bridge(ptr: ptr)
        let weakObj: NSObject? = obj
        XCTAssert(weakObj != nil)
        let ptr1 = bridge(obj: obj)
        XCTAssert(ptr == ptr1)
    }

    func testBridgeTransfer() {
        weak var weakObj: NSObject? = bridge(ptr: ptr)
        XCTAssert(weakObj != nil)
        var obj: NSObject = bridgeTransfer(ptr: ptr)
        XCTAssert(weakObj == obj)
        obj = NSObject()
        XCTAssert(weakObj == nil)
        ptr = bridgeRetained(obj: NSObject())
    }

    func testBridgeReleasedOnSetEmpty() throws {
        weak var weakObj: NSObject? = bridge(ptr: ptr)
        XCTAssert(weakObj != nil)
        Unmanaged<NSObject>.fromOpaque(ptr).release()
        XCTAssert(weakObj == nil)
        ptr = bridgeRetained(obj: NSObject())
    }
}
