//
//  BinaryHeapTests.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 23.10.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class BinaryHeapTests: XCTestCase {
    var sut = BinaryHeap<Int, Int>()
    
    override func tearDownWithError() throws {
        sut = BinaryHeap<Int, Int>()
    }
    
    func testEmpty() throws {
        XCTAssertTrue(sut.isEmpty)
        XCTAssertNil(sut.pop())
        XCTAssertNil(sut.peek())
    }
    
    func testSingle() {
        sut.Push(value: 0, priority: 0)
        XCTAssertFalse(sut.isEmpty)
        XCTAssertEqual(sut.peek(), 0)
        sut[0] = 1
        XCTAssertEqual(sut.getPriority(of: 0), 0)
        XCTAssertEqual(sut.pop(), 1)
        XCTAssertTrue(sut.isEmpty)
        
        sut.Push(value: 0, priority: 0)
        sut.changePriority(of: 0, to: 1)
        XCTAssertEqual(sut.getPriority(of: 0), 1)
        XCTAssertEqual(sut.pop(), 0)
        XCTAssertTrue(sut.isEmpty)
    }
    
    func testDouble() {
        sut.Push(value: 0, priority: 0)
        sut.Push(value: 0, priority: 0)
        XCTAssertEqual(sut.pop(), 0)
        XCTAssertEqual(sut.pop(), 0)
        
        XCTAssertTrue(sut.isEmpty)
        sut.Push(value: 0, priority: 0)
        sut.Push(value: 1, priority: 1)
        XCTAssertEqual(sut.pop(), 1)
        XCTAssertEqual(sut.pop(), 0)
        
        XCTAssertTrue(sut.isEmpty)
        sut.Push(value: 1, priority: 1)
        sut.Push(value: 0, priority: 0)
        XCTAssertEqual(sut.pop(), 1)
        XCTAssertEqual(sut.pop(), 0)
    }
    
    func testThree() {
        sut.Push(value: 0, priority: 0)
        sut.Push(value: 1, priority: 1)
        sut.Push(value: 2, priority: 2)
        XCTAssertEqual(sut.pop(), 2)
        XCTAssertEqual(sut.pop(), 1)
        XCTAssertEqual(sut.pop(), 0)
        XCTAssertTrue(sut.isEmpty)
        
        sut.Push(value: 0, priority: 0)
        sut.Push(value: 2, priority: 2)
        sut.Push(value: 1, priority: 1)
        XCTAssertEqual(sut.pop(), 2)
        XCTAssertEqual(sut.pop(), 1)
        XCTAssertEqual(sut.pop(), 0)
        XCTAssertTrue(sut.isEmpty)
        
        sut.Push(value: 2, priority: 2)
        sut.Push(value: 0, priority: 0)
        sut.Push(value: 1, priority: 1)
        XCTAssertEqual(sut.pop(), 2)
        XCTAssertEqual(sut.pop(), 1)
        XCTAssertEqual(sut.pop(), 0)
        XCTAssertTrue(sut.isEmpty)
    }
    
    func testFour() {
        sut.Push(value: 0, priority: 0)
        sut.Push(value: 1, priority: 1)
        sut.Push(value: 2, priority: 2)
        sut.Push(value: 3, priority: 3)
        XCTAssertEqual(sut.pop(), 3)
        XCTAssertEqual(sut.pop(), 2)
        XCTAssertEqual(sut.pop(), 1)
        XCTAssertEqual(sut.pop(), 0)
        XCTAssertTrue(sut.isEmpty)
    }
        
    func testArrayLiteral() {
        sut = [(0, 0), (1, 1), (2, 2), (3, 3)]
        XCTAssertTrue(sut.checkValid())
        XCTAssertEqual(sut.pop(), 3)
        XCTAssertEqual(sut.pop(), 2)
        XCTAssertEqual(sut.pop(), 1)
        XCTAssertEqual(sut.pop(), 0)
        XCTAssertTrue(sut.isEmpty)
    }
    
    func testStringConversion() {
        sut = [(0,0), (1, 1), (2, 2)]
        XCTAssertEqual("\(sut)", "[2, 1, 0]")
    }
    
    func testStringBinaryHeap() {
        var bh = BinaryHeap<String, Double>()
        bh = [("a", 1), ("b", 2), ("c", 3)]
        XCTAssertEqual(bh.pop(), "c")
        XCTAssertEqual(bh.pop(), "b")
        XCTAssertEqual(bh.pop(), "a")
    }
    
    func testChangePriorityQueue() {
        sut = [(0,0), (1, 1), (2, 2), (3, 3)]
        XCTAssertEqual(sut.peek(), 3)
        sut.changePriority(of: 0, to: -1)
        XCTAssertEqual(sut.first, 2)
        let v2 = sut[2]
        sut.changePriority(of: 2, to: 5)
        XCTAssertEqual(sut.peek(), v2)
        let v1 = sut[1]
        sut.changePriority(of: 1, to: sut.getPriority(of: 1))
        XCTAssertEqual(sut[1], v1)
    }
    
    func testCustomCompare() {
        var bh = BinaryHeap<String, Double>(compare: <)
        bh.Push(value: "a", priority: 0)
        bh.Push(value: "b", priority: 1)
        bh.Push(value: "c", priority: 2)

        XCTAssertEqual(bh.pop(), "a")
        XCTAssertEqual(bh.pop(), "b")
        XCTAssertEqual(bh.pop(), "c")
    }
    

    func testSafeSubscript() {
        // For 100% coverage of Collection safe subscript
        sut = [(0,0)]
        XCTAssertNil(sut[safe: -1])
        XCTAssertEqual(sut[safe: 0], 0)
        XCTAssertNil(sut[safe: 1])
    }
        
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}

extension BinaryHeap {
    func checkValid(from index: Int = 0) -> Bool {
        guard index < count / 2 else { return true }
        let left = getLeftChild(index)
        let right = getRightChild(index)
        if right == count {
            return !compare(storage[left].priority, storage[index].priority)
        }
        if compare(Swift.max(storage[left].priority, storage[right].priority), storage[index].priority)  {
            return false
        }
        return checkValid(from: left) && checkValid(from: right)
    }
}
