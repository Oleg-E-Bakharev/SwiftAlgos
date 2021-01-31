//
//  BitPtrTests.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 31.01.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class BitPtrTests: XCTestCase {
    typealias TestType = BitPtr<NSObject>

    var ptr = TestType(nil)

    override func setUpWithError() throws {
        ptr = TestType(nil)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCreate() throws {
        ptr = TestType(NSObject())
        XCTAssertNotNil(ptr.target)
    }

    func testBit() throws {
        ptr.bit = true
        XCTAssertTrue(ptr.bit)
        ptr.bit = false
        XCTAssertFalse(ptr.bit)
    }

    func testPtr() throws {
        ptr.bit = true
        XCTAssertNil(ptr.target)
        let obj = NSObject()
        ptr.target = obj
        XCTAssert(ptr.target === obj)
        XCTAssertTrue(ptr.bit)
    }

    func testPtrRemansWhenBitChanged() throws {
        ptr.bit = true
        let obj = NSObject()
        ptr.target = obj
        ptr.bit = false
        XCTAssert(ptr.target === obj)
        XCTAssertFalse(ptr.bit)
    }

    func testBitRemainsWhenPtrChanged() throws {
        ptr.bit = true
        let obj = NSObject()
        ptr.target = obj
        XCTAssert(ptr.target === obj)
        ptr.target = nil
        XCTAssertNil(ptr.target)
        XCTAssertTrue(ptr.bit)
    }
}
