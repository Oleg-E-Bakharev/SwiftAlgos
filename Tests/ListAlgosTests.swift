//
//  ListAlgosTests.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 15.09.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import XCTest
@testable import SwiftAlgosLib

class ListAlgosTests: XCTestCase {

    private var list: List<Int> = List()
    
    override func setUpWithError() throws {
        list = List()
    }

    override func tearDownWithError() throws {
        
    }

    func testReverse() throws {
        list = [1, 2 ,3, 4 ,5]
        list.reverse()
        XCTAssertEqual(String(describing: list), "5 -> 4 -> 3 -> 2 -> 1")
    }
}
