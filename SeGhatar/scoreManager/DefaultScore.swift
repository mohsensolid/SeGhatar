//
//  DefaultScore.swift
//  SeGhatar
//
//  Created by MAC on 7/25/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import Foundation
class DefaultScore {
    var delegate:ScoreDelegate?
    var scoreBase:BaseScoreDelegate?
    let steps:[Step] = [Step(row:1,col:0),Step(row: 0, col: 1)]
    init(delegate:ScoreDelegate) {
        self.delegate = delegate
        self.scoreBase = ScoreManagerBase(directions:steps, delegate: self)
    }
}
extension DefaultScore:BaseDelegate{
    func score(redScore: Int, blueScore: Int) {
        self.delegate?.score(redScore: redScore, blueScore: blueScore)
    }
    
    func gameIsEnded(redScore:Int,blueScore:Int) {
        self.delegate?.gameIsEnded(redScore: redScore, blueScore: blueScore)
    }
}
extension DefaultScore:ScoreManager{
    func evaluateBoard(board: [[Int]]) -> Int {
       return self.scoreBase!.evaluateBoard(board: board)
    }
    
    
    func resetTheGame() {
        self.scoreBase?.reset()
    }
    
    func cellChangeAt(row: Int, col: Int, layer: Int, player: Player) {
        self.scoreBase?.cellChangeAt(row: row, col: col, layer: layer, player: player)
    }
    
    func dispose() {
        delegate = nil
        scoreBase = nil
    }
    
   
    
    func getBoard() -> [[Int]] {
        return self.scoreBase!.getBoard()
    }
}
