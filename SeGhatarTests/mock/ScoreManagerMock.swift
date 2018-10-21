//
//  ScoreManagerMock.swift
//  SeGhatarTests
//
//  Created by MAC on 7/28/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import Foundation
@testable import SeGhatar
class ScoreManagerMock: ScoreManager {
    var resetTheGameVerify:Bool = false
    var cellChangeAtVerify:Bool = false
    var disposeVerify:Bool = false
    var evaluateBoardVerify:Bool = false
    func resetTheGame() {
        resetTheGameVerify = true
    }
    
    func cellChangeAt(row: Int, col: Int, layer: Int, player: Player) {
        cellChangeAtVerify = true
    }
    
    func dispose() {
        disposeVerify = true
    }
    
    func evaluateBoard(board: [[Int]]) -> Int {
        evaluateBoardVerify = true
        return 1
    }
    
    func getBoard() -> [[Int]] {
        return [[1,1]]
    }
  
    init() {
        
    }
}
