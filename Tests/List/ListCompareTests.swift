//
//  ListCompareTests.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 05.03.2021.
//  Copyright © 2021 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class ListCompareTests: XCTestCase {
    typealias EnumNode = EnumListNode<Int>
    typealias Node = ListNode<Int>

    var el: EnumNode = [1]
    var li: ListNode = [1]

    override func setUpWithError() throws {
        el = [1]
        li = [1]
    }

    override func tearDownWithError() throws {
        el = [1]
        el = [1]
    }

    func testListReversePerformance() throws {
        for i in 2..<50000 {
            li = li.push(i)
        }
        self.measure {
            li = ListNode.reverse(li) ?? [1]
        }
    }

    func testEnumListReversePerformance() throws {
        // On 90000 Stackoverflow
        for i in 2..<50000 {
            el.push(i)
        }
        self.measure {
            el = el.reversed()
        }
    }
}
