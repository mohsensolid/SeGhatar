//
//  ScoreManager.swift
//  SeGhatar
//
//  Created by MAC on 7/25/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import Foundation

protocol ScoreManager {
    func resetTheGame();
    func cellChangeAt(row:Int,col:Int,layer:Int,player:Player)
    func dispose()
    func evaluateBoard(board:[[Int]]) -> Int
    func getBoard() -> [[Int]]
}
