//
//  LocalGameManager.swift
//  SeGhatar
//
//  Created by MAC on 7/25/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import Foundation
class LocalGameManager:GameManagerDelegate {
   
    
    var delegate:GameDelegate?
    var currentPlayer:Player = Player.Red
    init(delegate:GameDelegate) {
        self.delegate = delegate
    }
    func isYourTurn() -> Bool {
        return true
    }
    
    func cellTappedAt(row: Int, col: Int, layer: Int) {
        delegate?.changeItemAt(row: row, col: col, layer: layer, player: currentPlayer)
        if currentPlayer == Player.Red{
            currentPlayer = Player.Blue
        }else{
            currentPlayer = Player.Red
        }
    }
    
    func dispose() {
        delegate = nil
    }
    
    func restart() {
        currentPlayer = Player.Red
    }
    
    func sendMessage(message: String) {
        
    }
}
