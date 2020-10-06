//
//  MutableCollectionExTests.swift
//  SwiftAlgosTests
//
//  Created by Oleg Bakharev on 06.10.2020.
//  Copyright © 2020 Oleg Bakharev. All rights reserved.
//

import XCTest

class MutableCollectionExTests: XCTestCase {
    
    var sut: [Int] = []

    override func setUpWithError() throws {
        sut = []
    }

    func testReverseEmpty() throws {
        sut.reverse(from: 0, to: 0)
        XCTAssertTrue(sut.isEmpty)
    }
    
    func testReverseSingle() throws {
        sut = [1]
        
        sut.reverse(from: 0, to: 0)
        XCTAssertEqual(sut, [1])
        
        sut.reverse(from: 1, to: 1)
        XCTAssertEqual(sut, [1])

        sut.reverse(from: 0, to: 1)
        XCTAssertEqual(sut, [1])
    }

    func testReverseDouble() throws {
        sut = [1, 2]
        sut.reverse(from: 0, to: 1)
        XCTAssertEqual(sut, [1, 2])

        sut.reverse(from: 1, to: 2)
        XCTAssertEqual(sut, [1, 2])

        sut.reverse(from: 0, to: 2)
        XCTAssertEqual(sut, [2, 1])
    }
    
    func testReverseTriple() throws {
        sut = [1, 2, 3]
        sut.reverse(from: 0, to: 2)
        XCTAssertEqual(sut, [2, 1, 3])

        sut = [1, 2, 3]
        sut.reverse(from: 1, to: 3)
        XCTAssertEqual(sut, [1, 3, 2])

        sut = [1, 2, 3]
        sut.reverse(from: 0, to: 3)
        XCTAssertEqual(sut, [3, 2, 1])
    }
    
    func testReverseQuad() throws {
        sut = [1, 2, 3, 4]
        sut.reverse(from: 1, to: 4)
        XCTAssertEqual(sut, [1, 4, 3, 2])

        sut = [1, 2, 3, 4]
        sut.reverse(from: 0, to: 4)
        XCTAssertEqual(sut, [4, 3, 2, 1])
    }
    
    func testRotateEmpty() throws {
        sut.rotate(on: 0)
        XCTAssertTrue(sut.isEmpty)
    }
    
    func testRotateSingle() throws {
        sut = [1]
        
        sut.rotate(on: 0)
        XCTAssertEqual(sut, [1])
        
        sut.rotate(on: 1)
        XCTAssertEqual(sut, [1])
    }
    
    func testRotateDouble() throws {
        sut = [1, 2]
        sut.rotate(on: 0)
        XCTAssertEqual(sut, [1, 2])

        sut.rotate(on: 1)
        XCTAssertEqual(sut, [2, 1])
    }
    
    func testRotateTriple() throws {
        sut = [1, 2, 3]
        sut.rotate(on: 0)
        XCTAssertEqual(sut, [1, 2, 3])
        
        sut.rotate(on: 1)
        XCTAssertEqual(sut, [2, 3, 1])
        
        sut = [1, 2, 3]
        sut.rotate(on: 2)
        XCTAssertEqual(sut, [3, 1, 2])
    }
}
