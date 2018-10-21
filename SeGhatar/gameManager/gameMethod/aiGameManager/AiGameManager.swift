//
//  AiGameManager.swift
//  SeGhatar
//
//  Created by MAC on 7/26/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import Foundation
class AiGameManager: GameManagerDelegate {
    var delegate:GameDelegate?
    var isUserTurn:Bool = true
    var scoreManager:ScoreManager?
    init(delegate:GameDelegate,scoreManager:ScoreManager) {
        self.delegate = delegate
        self.scoreManager = scoreManager
    }
    func isYourTurn() -> Bool {
        return isUserTurn
    }
    
    func cellTappedAt(row: Int, col: Int, layer: Int) {
        self.delegate?.changeItemAt(row: row, col: col, layer: layer, player: Player.Red)
        self.isUserTurn = false
        let board = scoreManager?.getBoard()
        let miniMax = MiniMax(delegate: self.scoreManager!)
        let aiMove = miniMax.bestMove(board: board!)
        self.delegate?.changeItemAt(row: aiMove!.row, col: aiMove!.col, layer: aiMove!.layer, player: Player.Blue)
        self.isUserTurn = true
    }
    
    func dispose() {
        self.delegate = nil
        self.scoreManager = nil
    }
    
    func restart() {
        
    }
    
    func sendMessage(message: String) {
        
    }
}
