//
//  ListTest.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 13.09.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class ListTest: XCTestCase {
    private var list: List<Int> = List()
    
    override func setUp() {
        list = List()
    }

    override func tearDown() {
        
    }

    func testEmpty() {
        XCTAssert(list.count == 0)
        XCTAssertTrue(list.isEmpty)
        list.push(1)
        XCTAssertFalse(list.isEmpty)
        XCTAssert(list.count == 1)
        list.pop()
        XCTAssertTrue(list.isEmpty)
        XCTAssert(list.count == 0)
    }
    
    func testPushOne() {
        list.push(1)
        XCTAssertFalse(list.isEmpty)
        XCTAssert(list.count == 1)
        XCTAssertEqual(list.pop(), 1)
        XCTAssert(list.count == 0)
        XCTAssertTrue(list.isEmpty)
    }
    
    func testAppendOne() {
        list.push(1)
        XCTAssertEqual(list.pop(), 1)
    }
    
    func testHeadEqualsTailAfterPushPop() {
        XCTAssertNil(list.head)
        XCTAssert(list.head === list.tail)
        list.push(1)
        XCTAssertNotNil(list.head)
        XCTAssert(list.head === list.tail)
        list.pop()
        XCTAssertNil(list.head)
        XCTAssert(list.head === list.tail)
    }

    func testHeadEqualsTailAfterAppendPop() {
        XCTAssertNil(list.head)
        XCTAssert(list.head === list.tail)
        list.append(1)
        XCTAssertNotNil(list.head)
        XCTAssert(list.head === list.tail)
        list.pop()
        XCTAssertNil(list.head)
        XCTAssert(list.head === list.tail)
    }

    func testPush() {
        list.push(1)
        list.push(2)
        XCTAssertEqual(list.pop(), 2)
        XCTAssertEqual(list.pop(), 1)
        XCTAssertTrue(list.isEmpty)
    }
    
    func testAppend() {
        list.append(1)
        list.append(2)
        XCTAssertEqual(list.pop(), 1)
        XCTAssertEqual(list.pop(), 2)
        XCTAssertTrue(list.isEmpty)
    }

    func testInsertAfterTail() {
        list.append(1)
        list.insert(2, after: list.tail!)
        list.insert(3, after: list.tail!)
        XCTAssertEqual(list.pop(), 1)
        XCTAssertEqual(list.pop(), 2)
        XCTAssertEqual(list.pop(), 3)
    }
    
    func testInsertAfterHead() {
        list.append(1)
        list.insert(2, after: list.head!)
        list.insert(3, after: list.head!)
        XCTAssertEqual(list.pop(), 1)
        XCTAssertEqual(list.pop(), 3)
        XCTAssertEqual(list.pop(), 2)
    }
    
    func testRemove() {
        list.append(1)
        XCTAssertNil(list.remove(after: list.head!))
        XCTAssertFalse(list.isEmpty)
        list.append(2)
        list.append(3)
        XCTAssertEqual(list.remove(after: list.head!), 2)
        XCTAssertEqual(list, List(1, 3))
    }
    
    func testInitArrayLiteral() {
        list = [1, 2, 3]
        XCTAssertEqual(list.head!.value, 1)
        XCTAssertEqual(list.head!.next!.value, 2)
        XCTAssertEqual(list.tail!.value, 3)
    }
    
    func testSequence() {
        list = [1, 2, 3]
        var v = 1
        for i in list {
            XCTAssertEqual(i, v)
            v += 1
        }
    }
    
    func testDescripion() {
        XCTAssertEqual(String(describing: list), "Empty list")
        list.append(1)
        XCTAssertEqual(String(describing: list), "1")
        list.append(2)
        XCTAssertEqual(String(describing: list), "1 -> 2")
    }
    
    func testCopyOnWrite() {
        list = [1, 2, 3]
        var list1 = list
        list1.append(4)
        XCTAssertEqual(list, List(1, 2, 3))
        XCTAssertEqual(list1, List(1, 2, 3, 4))
    }

    func testCopyOnWriteOnInsertAfterHead() {
        list = [1, 3]
        let list1 = list
        list.insert(2, after: list.head!)
        XCTAssertEqual(list, List(1, 2, 3))
        XCTAssertEqual(list1, List(1, 3))
    }

    func testCopyOnWriteOnRemoveAfterHead() {
        list = [1, 2, 3]
        let list1 = list
        list.remove(after: list.head!)
        XCTAssertEqual(list, List(1, 3))
        XCTAssertEqual(list1, List(1, 2, 3))
    }

    func testCopyOnWriteOnInsertNotAfterHead() {
        list = [1, 2, 4]
        let list1 = list
        list.insert(3, after: list.head!.next!)
        XCTAssertEqual(list, List(1, 2, 3, 4))
        XCTAssertEqual(list1, List(1, 2, 4))
    }

    func testCopyOnWriteOnRemoveNotAfterHead() {
        list = [1, 2, 3]
        let list1 = list
        list.remove(after: list.head!.next!)
        XCTAssertEqual(list, List(1, 2))
        XCTAssertEqual(list1, List(1, 2, 3))
    }

    
    func testPushAvoidCopyOnWrite() {
        list = [1, 2, 3]
        var list1 = list
        list1.push(0)
        XCTAssertEqual(list, List(1, 2, 3))
        XCTAssertEqual(list1, List(0, 1, 2, 3))
    }
    
    func testPopAvoidCopyOnWrite() {
        list = [1, 2, 3, 4]
        var list1 = list
        list1.pop()
        XCTAssertEqual(list, List(1, 2, 3, 4))
        XCTAssertEqual(list1, List(2, 3, 4))
    }

    func testInoutAvoidCopyOnWrite()  {
        func fulfil(_ list: inout List<Int>) {
            list.append(2)
        }
        list = [1]
        fulfil(&list)
        XCTAssertEqual(list, List(1, 2))
    }

    func testListEquateble() {
        list = []
        var list1: List<Int> = []
        XCTAssertEqual(list, list1)
        list.push(1)
        XCTAssertNotEqual(list, list1)
        list1.push(1)
        XCTAssertEqual(list, list1)
        list1.push(2)
        XCTAssertNotEqual(list, list1)
        list1.pop()
        XCTAssertEqual(list, list1)
        list1.pop()
        XCTAssertNotEqual(list, list1)
        list1.push(3)
        XCTAssertNotEqual(list, list1)
        list1.pop()
        list1.push(1)
        XCTAssertEqual(list, list1)
    }

    func testListLiterals() {
        var list: List<Character> = "abc"
        list.pop()
        XCTAssertEqual(list, List("bc"))

        list = .init(unicodeScalarLiteral: "ñ")
        XCTAssertEqual(list, List("ñ"))

        list = .init(extendedGraphemeClusterLiteral: "🇷🇺")
        XCTAssertEqual(list, List("🇷🇺"))
    }

    func testListPush() throws {
        var li: ListNode = [1]
        for i in 2..<10 {
            li = li.push(i)
        }
        var li2 = ListNode.reverse(li) ?? [1]
        li2 = ListNode.reverse(li2) ?? [1]
        XCTAssertEqual(li, li2)
    }
}
