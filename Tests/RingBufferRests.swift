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
        XCTAssertEqual(sut.front, 0)
        XCTAssertEqual(sut.back, 0)
        XCTAssertEqual(sut.popFront(), 1)
        XCTAssertTrue(sut.isEmpty)
        sut.pushFront(1)
        sut.pushFront(2)
        XCTAssertEqual(sut.front, 0)
        XCTAssertEqual(sut.back, 0)
        XCTAssertEqual(sut.popFront(), 2)
        XCTAssertEqual(sut.popFront(), 1)
        XCTAssertTrue(sut.isEmpty)
    }

    func testPushPopBack() throws {
        sut.pushBack(1)
        XCTAssertEqual(sut.front, 0)
        XCTAssertEqual(sut.back, 0)
        XCTAssertEqual(sut.popBack(), 1)
        XCTAssertTrue(sut.isEmpty)
        sut.pushBack(1)
        sut.pushBack(2)
        XCTAssertEqual(sut.front, 1)
        XCTAssertEqual(sut.back, 1)
        XCTAssertEqual(sut.popBack(), 2)
        XCTAssertEqual(sut.popBack(), 1)
        XCTAssertTrue(sut.isEmpty)
        sut.pushBack(1)
        sut.pushBack(2)
        sut.pushBack(3)
    }
    
    func testPushFrontPopBack() throws {
        sut.pushFront(1)
        XCTAssertEqual(sut.popBack(), 1)
        XCTAssertTrue(sut.isEmpty)
        sut.pushFront(1)
        sut.pushFront(2)
        XCTAssertEqual(sut.popBack(), 1)
        XCTAssertEqual(sut.popBack(), 2)
        XCTAssertTrue(sut.isEmpty)
    }

    func testPushBackPopFront() throws {
        sut.pushBack(1)
        XCTAssertEqual(sut.popFront(), 1)
        XCTAssertTrue(sut.isEmpty)
        sut.pushBack(1)
        sut.pushBack(2)
        XCTAssertEqual(sut.popFront(), 1)
        XCTAssertEqual(sut.popFront(), 2)
        XCTAssertTrue(sut.isEmpty)
    }
    
    func testPushFrontDescription() throws {
        XCTAssertEqual(String(describing: sut), "[]")
        sut.pushFront(1)
        XCTAssertEqual(String(describing: sut), "[1]")
        sut.pushFront(2)
        XCTAssertEqual(String(describing: sut), "[1, 2]")
        sut.pushFront(3)
        XCTAssertEqual(String(describing: sut), "[1, 2, 3]")
    }
    
    func testPushBackDescription() throws {
        sut.pushBack(2)
        XCTAssertEqual(String(describing: sut), "[2]")
        sut.pushBack(1)
        XCTAssertEqual(String(describing: sut), "[1, 2]")
        sut.pushBack(0)
        XCTAssertEqual(String(describing: sut), "[0, 1, 2]")
    }
    
    func testSequencePushFront() throws {
        sut.pushFront(sequence: [1, 2, 3, 4])
        XCTAssertEqual(String(describing: sut), "[1, 2, 3, 4]")
    }
    
    func testSequencePushBack() throws {
        sut.pushBack(sequence: [1, 2, 3, 4])
        XCTAssertEqual(String(describing: sut), "[4, 3, 2, 1]")
    }

    
    func testGrow() throws {
//        sut.pushFront(<#T##element: RingBuffer<Int>.Element##RingBuffer<Int>.Element#>)
    }

}
