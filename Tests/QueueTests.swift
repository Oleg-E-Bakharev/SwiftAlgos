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
    
    override func tearDown() {
        listQueue = []
        ringBufferQueue = []
    }
    
    func testQueueOne() {
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

    func testQueueRemoveAll() {
        doTestQueueRemoveAll(queue: &listQueue)
        doTestQueueRemoveAll(queue: &ringBufferQueue)

    }

    func doTestQueueRemoveAll<Q: Queue>(queue: inout Q) where Q.Element == Int {
        XCTAssertNil(queue.peek)
        queue.enqueue(1)
        queue.enqueue(2)
        queue.removeAll()
        XCTAssertNil(queue.peek)
        XCTAssertNil(queue.dequeue())
    }

    //    func doTestQueueEmpty<Q: Queue>(queue: inout Q) {
    //        XCTAssertNil(queue.peek)
    //    }
    
//    func testPerformanceLongListQueue() throws {
//        measure {
//            (0..<1000).forEach { listQueue.enqueue($0) }
//            listQueue.forEach { _ in listQueue.dequeue() }
//        }
//    }
//
//    func testPerformanceShortListQueue() throws {
//        measure {
//            (0..<1000).forEach {
//                listQueue.enqueue($0)
//                listQueue.dequeue()
//            }
//        }
//    }
//
//    func testPerformanceLongRingQueue() throws {
//        measure {
//            (0..<1000).forEach { ringBufferQueue.enqueue($0) }
//            ringBufferQueue.forEach { _ in ringBufferQueue.dequeue() }
//        }
//    }
//
//    func testPerformanceShortRingQueue() throws {
//        measure {
//            (0..<1000).forEach {
//                ringBufferQueue.enqueue($0)
//                ringBufferQueue.dequeue()
//            }
//        }
//    }
}
