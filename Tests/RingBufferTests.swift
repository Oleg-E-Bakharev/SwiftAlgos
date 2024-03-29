//
//  RingBufferTests.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 03.10.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class RingBufferRests: XCTestCase {
    
    private var sut = RingBuffer<Int>()

    override func tearDownWithError() throws {
        sut = RingBuffer()
    }

    func testIsEmpty() throws {
        XCTAssertTrue(sut.isEmpty)
        XCTAssertNil(sut.popFront())
        XCTAssertNil(sut.popBack())
        XCTAssert(sut.count == 0)
    }
    
    func testFrontBack() throws {
        XCTAssertNil(sut.first)
        XCTAssertNil(sut.last)
        sut = [1, 2]
        XCTAssertEqual(sut.front, 2)
        XCTAssertEqual(sut.back, 1)
        XCTAssert(sut.count == 2)
        sut.popFront()
        XCTAssert(sut.count == 1)
        XCTAssertEqual(sut.front, 1)
        XCTAssertEqual(sut.back, 1)
        XCTAssertEqual(sut.popBack(), 1)
        XCTAssert(sut.count == 0)
        XCTAssertTrue(sut.isEmpty)
        XCTAssertNil(sut.first)
        XCTAssertNil(sut.last)
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
        XCTAssertEqual(sut.first, 0)
        XCTAssertEqual(sut.front, 1)
        XCTAssertEqual(sut.back, 1)
        XCTAssertFalse(sut.isEmpty)
        XCTAssertEqual(sut.last, 0)
        XCTAssertEqual(sut.popFront(), 1)
        XCTAssertTrue(sut.isEmpty)
        XCTAssertNil(sut.first)
        XCTAssertNil(sut.last)
        sut.pushFront(1)
        XCTAssertFalse(sut.isEmpty)
        sut.pushFront(2)
        XCTAssertFalse(sut.isEmpty)
        XCTAssertEqual(sut.first, 0)
        XCTAssertEqual(sut.last, 0)
        XCTAssertEqual(sut.popFront(), 2)
        XCTAssertFalse(sut.isEmpty)
        XCTAssertEqual(sut.popFront(), 1)
        XCTAssertTrue(sut.isEmpty)
    }

    func testPushPopBack() throws {
        sut.pushBack(1)
        XCTAssertFalse(sut.isEmpty)
        XCTAssertEqual(sut.first, 0)
        XCTAssertEqual(sut.last, 0)
        XCTAssertEqual(sut.popBack(), 1)
        XCTAssertTrue(sut.isEmpty)
        sut.pushBack(1)
        XCTAssertFalse(sut.isEmpty)
        sut.pushBack(2)
        XCTAssertFalse(sut.isEmpty)
        XCTAssertEqual(sut.first, 1)
        XCTAssertEqual(sut.last, 1)
        XCTAssertEqual(sut.popBack(), 2)
        XCTAssertFalse(sut.isEmpty)
        XCTAssertEqual(sut.popBack(), 1)
        XCTAssertTrue(sut.isEmpty)
    }
    
    func testPushFrontPopBack() throws {
        sut.pushFront(1)
        XCTAssertEqual(sut.popBack(), 1)
        XCTAssertTrue(sut.isEmpty)
        sut.pushFront(1)
        sut.pushFront(2)
        XCTAssertEqual(sut.popBack(), 1)
        XCTAssertFalse(sut.isEmpty)
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
        XCTAssertEqual(String(describing: sut), "[1, 2, 3, 4]")
    }

    func testArrayLiteral() throws {
        sut = [1, 2, 3, 4]
        XCTAssertEqual(String(describing: sut), "[1, 2, 3, 4]")
    }
    
    func testPushFrontGrow1() throws {
        sut.pushFront(1)
        XCTAssertEqual(sut.last, 0)
        XCTAssertEqual(sut.first, 0)
        sut.pushFront(2)
        XCTAssertEqual(sut.last, 0)
        XCTAssertEqual(sut.first, 0)
    }

    func testPushBackGrow1() throws {
        sut.pushBack(1)
        XCTAssertEqual(sut.last, 0)
        XCTAssertEqual(sut.first, 0)
        sut.pushBack(2)
        XCTAssertEqual(sut.last, 1)
        XCTAssertEqual(sut.first, 1)
    }
        
    func testPushPopBackSeries1() throws {
        sut.reserveCapacity(10)
        XCTAssertEqual(sut.count, 0)
        sut = [1, 2, 3, 4]
        XCTAssertEqual(sut.popBack(), 1)
        XCTAssertEqual(sut.popFront(), 4)
        XCTAssertEqual(String(describing: sut), "[2, 3]")
        sut.pushBack(sequence: [0, 1])
        XCTAssertEqual(String(describing: sut), "[0, 1, 2, 3]")
    }

    func testPushPopBackSeries2() throws {
        sut = [1, 2, 3, 4]
        XCTAssertEqual(sut.popBack(), 1)
        XCTAssertEqual(sut.popFront(), 4)
        XCTAssertEqual(String(describing: sut), "[2, 3]")
        sut.pushBack(sequence: [-5, -4, -3, -2, -1, 0, 1])
        XCTAssertEqual(String(describing: sut), "[-5, -4, -3, -2, -1, 0, 1, 2, 3]")
    }

    func testPushPopFrontSeries1() throws {
        sut = [1, 2, 3, 4]
        XCTAssertEqual(sut.popBack(), 1)
        XCTAssertEqual(sut.popFront(), 4)
        XCTAssertEqual(String(describing: sut), "[2, 3]")
        sut.pushFront(sequence: [4, 5])
        XCTAssertEqual(String(describing: sut), "[2, 3, 4, 5]")
    }
    
    func testPushPopFrontSeries2() throws {
        sut = [1, 2, 3, 4]
        XCTAssertEqual(sut.popBack(), 1)
        XCTAssertEqual(sut.popFront(), 4)
        XCTAssertEqual(String(describing: sut), "[2, 3]")
        sut.pushFront(sequence: [4, 5, 6, 7, 8, 9, 10])
        XCTAssertEqual(String(describing: sut), "[2, 3, 4, 5, 6, 7, 8, 9, 10]")
    }
    
    func testPushForntCollection() throws {
        sut = [1, 2, 3, 4]
        sut.pushFront(collection: [5, 6, 7, 8])
        XCTAssertEqual(sut, [1, 2, 3, 4, 5, 6 ,7 ,8])
    }
    
    func testPushBackCollection() throws {
        sut = [5, 6, 7, 8]
        sut.pushBack(collection: [1, 2, 3, 4])
        XCTAssertEqual(sut, [1, 2, 3, 4, 5, 6 ,7 ,8])
    }

    func testReserveCapacity() throws {
        sut = [1, 2, 3, 4]
        sut.reserveCapacity(0)
        XCTAssertEqual(String(describing: sut), "[1, 2, 3, 4]")
        sut.popFront()
        sut.popBack()
        XCTAssertEqual(String(describing: sut), "[2, 3]")
        sut.reserveCapacity(10)
        XCTAssertEqual(String(describing: sut), "[2, 3]")
        sut.pushBack(1)
        sut.pushFront(4)
        XCTAssertEqual(String(describing: sut), "[1, 2, 3, 4]")
    }
    
    func testRandomAccess() throws {
        XCTAssertEqual(sut.count, 0)
        sut = [1, 2]
        XCTAssertEqual(sut.count, 2)
        XCTAssertEqual(sut[0], 1)
        XCTAssertEqual(sut[1], 2)
        sut[0] = 2
        sut[1] = 1
        XCTAssertEqual(sut[0], 2)
        XCTAssertEqual(sut[1], 1)
    }
    
    func testMutableCollection() throws {
        sut = [1, 2]
        sut.swapAt(0, 1)
        XCTAssertEqual(sut[0], 2)
        XCTAssertEqual(sut[1], 1)
    }
    
    func testReplaceSubrange() {
        sut = [1, 2, 3, 4]
        sut.popFront()
        sut.popBack()

        sut.replaceSubrange(0...1, with: [2, 1, 0])
        XCTAssertEqual(sut[0], 2)
        XCTAssertEqual(sut[1], 1)
        XCTAssertEqual(sut[2], 0)
    }
    
    func testReplaceSubrangeWhenRangeEquals() {
        sut = [1, 2, 3, 4]
        sut.popFront()
        sut.popBack()

        sut.replaceSubrange(0...1, with: [2, 1])
        XCTAssertEqual(sut[0], 2)
        XCTAssertEqual(sut[1], 1)
    }
    
    func testReplaceSubrangeWhenRangeShorterThenNew() {
        sut = [1, 2, 3, 4]

        sut.replaceSubrange(1...2, with: [2, 2, 3, 3])
        XCTAssertEqual(sut, [1, 2, 2, 3, 3, 4])
    }
    
    func testReplaceSubrangeWhenRangeLongerThenNew() {
        sut = [0, 1, 2, 3, 4, 5, 6]
        sut.popFront()
        sut.popBack()

        sut.replaceSubrange(1...3, with: [2, 2])
        XCTAssertEqual(sut, [1, 2, 2, 5])
    }
    
    func testReplaceSubrangeWithRangeWhenWasEmpty() {
        sut.replaceSubrange(0..<0, with: [1, 2, 3])
        XCTAssertEqual(sut, [1, 2, 3])
    }
    
    func testReplaceSubrangeWithRangeWhenWillEmpty() {
        sut = [1, 2, 3]
        sut.replaceSubrange(0..<3, with: [])
        XCTAssertEqual(sut, [])
        XCTAssert(sut.isEmpty)
        XCTAssert(sut.count == 0)
    }
    
    func testReplaceSubrangeWithEmptyRangeWhenWillSingle() {
        sut = [1, 2, 3]
        sut.replaceSubrange(0..<2, with: [])
        XCTAssertEqual(sut, [3])
        XCTAssertFalse(sut.isEmpty)
        XCTAssert(sut.count == 1)
    }

    func testReplaceSubrangeWithRangeWhenEmpty() {
        sut = []
        sut.replaceSubrange(0..<0, with: [])
    }
    
//    func testPerformanceRingBufferReplaceSubrange() {
//        self.measure {
//             (0..<100).forEach { _ in
//                testReplaceSubrange()
//            }
//        }
//    }
//    
//    func testPerformanceRingBufferReplaceSubrangeRangeEquals() {
//        self.measure {
//             (0..<100).forEach { _ in
//                testReplaceSubrangeWhenRangeEquals()
//            }
//        }
//    }

}
