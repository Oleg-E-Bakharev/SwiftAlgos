//
//  QueueTests.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 19.10.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class QueueTests: XCTestCase {
    var listQueue: List<Int> = []
    var ringBufferQueue: RingBuffer<Int> = []
    
    override func tearDownWithError() throws {
        listQueue = []
        ringBufferQueue = []
    }
    
    func testQueueOne() throws {
        doTestQueueOne(queue: &listQueue)
        doTestQueueOne(queue: &ringBufferQueue)
    }
    
    func doTestQueueOne<Q: Queue>(queue: inout Q) where Q.Element == Int {
        XCTAssertNil(queue.peek)
        queue.enqueue(1)
        XCTAssertEqual(queue.peek, 1)
        XCTAssertEqual(queue.dequeue(), 1)
        XCTAssertNil(queue.peek)
        XCTAssertNil(queue.dequeue())
    }
    
    //    func doTestQueueEmpty<Q: Queue>(queue: inout Q) {
    //        XCTAssertNil(queue.peek)
    //    }
    
    func testPerformanceLongListQueue() throws {
        self.measure {
            (0..<1000).forEach { listQueue.enqueue($0) }
            listQueue.forEach { _ in listQueue.dequeue() }
        }
    }
    
    func testPerformanceShortListQueue() throws {
        self.measure {
            (0..<1000).forEach {
                listQueue.enqueue($0)
                listQueue.dequeue()
            }
        }
    }
    
    func testPerformanceLongRingQueue() throws {
        self.measure {
            (0..<1000).forEach { ringBufferQueue.enqueue($0) }
            ringBufferQueue.forEach { _ in ringBufferQueue.dequeue() }
        }
    }
    
    func testPerformanceShortRingQueue() throws {
        self.measure {
            (0..<1000).forEach {
                ringBufferQueue.enqueue($0)
                ringBufferQueue.dequeue()
            }
        }
    }
}
