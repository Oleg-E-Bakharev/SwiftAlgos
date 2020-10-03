//
//  RingBufferRests.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 03.10.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class RingBufferRests: XCTestCase {
    
    private var sut = RingBuffer<Int>()

    override func setUpWithError() throws {
        sut = RingBuffer()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIsEmpty() throws {
        XCTAssertTrue(sut.isEmpty)
        XCTAssertNil(sut.popFront())
        XCTAssertNil(sut.popBack())
    }

    func testNotIsEmptyAfterPushFront() throws {
        sut.pushFront(1)
        XCTAssertFalse(sut.isEmpty)
    }

    func testNotIsEmptyAfterPushBack() throws {
        sut.pushBack(1)
        XCTAssertFalse(sut.isEmpty)
    }

    func testPushPopFront() throws {
        sut.pushFront(1)
        XCTAssertEqual(sut.popFront(), 1)
        XCTAssertTrue(sut.isEmpty)
    }

    func testPushPopBack() throws {
        sut.pushBack(1)
        XCTAssertEqual(sut.popBack(), 1)
        XCTAssertTrue(sut.isEmpty)
    }
    
    func testPushFrontPopBack() throws {
        sut.pushFront(1)
        XCTAssertEqual(sut.popBack(), 1)
        XCTAssertTrue(sut.isEmpty)
    }

    func testPushBackPopFront() throws {
        sut.pushBack(1)
        XCTAssertEqual(sut.popFront(), 1)
        XCTAssertTrue(sut.isEmpty)
    }
    
    func testGrow() throws {
        sut.pushFront(<#T##element: RingBuffer<Int>.Element##RingBuffer<Int>.Element#>)
    }

}
