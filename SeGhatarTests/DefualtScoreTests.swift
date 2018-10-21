//
//  DefualtScoreTests.swift
//  SeGhatarTests
//
//  Created by MAC on 7/25/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import XCTest
@testable import SeGhatar

class DefualtScoreTests: XCTestCase {
    var defualtScore:DefaultScore?
    let mock:mockObject = mockObject()

    override func setUp() {
         defualtScore = DefaultScore(delegate: mock)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testTwoWithSameInRowColorIsNotPoint(){
        
        defualtScore?.cellChangeAt(row: 3, col: 2, layer: 1, player: Player.Red)
        defualtScore?.cellChangeAt(row: 3, col: 1, layer:1, player: Player.Red)
        XCTAssertTrue(mock.redScore == 0,"Expted 0")
        XCTAssertTrue(mock.scoreMethodVerfiy)

    }
    func testtwoColumnWithSameColorIsNotPoint(){
        
        defualtScore?.cellChangeAt(row: 0, col: 0, layer: 1, player: Player.Red)
        defualtScore?.cellChangeAt(row: 1, col: 0, layer:1, player: Player.Red)
        XCTAssertTrue(mock.scoreMethodVerfiy)
        XCTAssertTrue(mock.redScore == 0,"Expted 0")
        
    }
    func test3ColorInFirstRowIsPoint(){
        defualtScore?.cellChangeAt(row: 0, col: 0, layer: 3, player: Player.Red)
        defualtScore?.cellChangeAt(row: 0, col: 1, layer:3, player: Player.Red)
        defualtScore?.cellChangeAt(row: 0, col: 2, layer: 3, player: Player.Red)
        XCTAssertTrue(mock.redScore == 1)
    }
    func testIsFirstColumnWithSameColorIsPoint(){
      
        defualtScore?.cellChangeAt(row: 0, col: 0, layer: 3, player: Player.Red)
        defualtScore?.cellChangeAt(row: 1, col: 0, layer:3, player: Player.Red)
        defualtScore?.cellChangeAt(row: 2, col: 0, layer: 3, player: Player.Red)
        XCTAssertTrue(mock.scoreMethodVerfiy)
        XCTAssertTrue(mock.redScore == 1)
    }
    func test3CellWithDiffrentColorInSameColumnIsNotPoint(){
        defualtScore?.cellChangeAt(row: 0, col: 0, layer: 3, player: Player.Red)
        defualtScore?.cellChangeAt(row: 1, col: 0, layer:3, player: Player.Red)
        defualtScore?.cellChangeAt(row: 2, col: 0, layer: 3, player: Player.Blue)
        XCTAssertTrue(mock.redScore == 0)

    }
    
    func test3CellSameColorDiffrentLayerIsPoint(){
        defualtScore?.cellChangeAt(row: 0, col: 1, layer: 1, player: Player.Red)
        defualtScore?.cellChangeAt(row: 1, col: 1, layer:2, player: Player.Red)
        defualtScore?.cellChangeAt(row: 2, col: 1, layer: 3, player: Player.Red)
        
        XCTAssertTrue(mock.redScore == 1)
    }
    
    func test3CellDiffrentColorInDiffrentLayerIsNotPoint(){
        defualtScore?.cellChangeAt(row: 0, col: 1, layer: 1, player: Player.Red)
        defualtScore?.cellChangeAt(row: 0, col: 1, layer:2, player: Player.Red)
        defualtScore?.cellChangeAt(row: 0, col: 1, layer: 3, player: Player.Blue)
        XCTAssertTrue(mock.redScore == 0)
    }
    func test6CellInCenterColumnIs2Point(){
        defualtScore?.cellChangeAt(row: 0, col: 1, layer: 1, player: Player.Red)
        defualtScore?.cellChangeAt(row: 0, col: 1, layer:2, player: Player.Red)
        defualtScore?.cellChangeAt(row: 0, col: 1, layer: 3, player: Player.Red)
        defualtScore?.cellChangeAt(row: 2, col: 1, layer: 1, player: Player.Red)
        defualtScore?.cellChangeAt(row: 2, col: 1, layer:2, player: Player.Red)
        defualtScore?.cellChangeAt(row: 2, col: 1, layer: 3, player: Player.Red)
        XCTAssertTrue(mock.redScore == 2)
    }
    func test3BlueAnd3RedInRow(){
        
        defualtScore?.cellChangeAt(row: 1, col: 0, layer: 1, player: Player.Red)
        defualtScore?.cellChangeAt(row: 1, col: 0, layer:2, player: Player.Red)
        defualtScore?.cellChangeAt(row: 1, col: 0, layer: 3, player: Player.Red)
        
        defualtScore?.cellChangeAt(row: 1, col: 2, layer: 1, player: Player.Blue)
        defualtScore?.cellChangeAt(row: 1, col: 2, layer:2, player: Player.Blue)
        defualtScore?.cellChangeAt(row: 1, col: 2, layer: 3, player: Player.Blue)
        
        XCTAssertTrue(mock.redScore == 1)
        XCTAssertTrue(mock.blueScore == 1)

    }
    func test3CellJumpCenterIsNotPoint(){
        defualtScore?.cellChangeAt(row: 1, col: 0, layer: 1, player: Player.Blue)
        defualtScore?.cellChangeAt(row: 1, col: 0, layer:2, player: Player.Blue)
        defualtScore?.cellChangeAt(row: 1, col: 2, layer: 1, player: Player.Blue)
        
        XCTAssertTrue(mock.blueScore == 0)
    }
    
    func test3CellInTopLeftDiagnolIsNotPoint(){
        defualtScore?.cellChangeAt(row: 0, col: 0, layer: 1, player: Player.Blue)
        defualtScore?.cellChangeAt(row: 0, col: 0, layer:2, player: Player.Blue)
        defualtScore?.cellChangeAt(row: 0, col: 0, layer: 3, player: Player.Blue)
        XCTAssertTrue(mock.blueScore == 0)
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

