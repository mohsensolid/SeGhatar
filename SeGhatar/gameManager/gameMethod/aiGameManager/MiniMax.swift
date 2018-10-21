//
//  MiniMax.swift
//  SeGhatar
//
//  Created by MAC on 7/26/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import Foundation
import Darwin
class MiniMax {
    let maxValue:Int = 10000
    let minValue:Int = -10000
    var delegate:ScoreManager?
    init(delegate:ScoreManager) {
        self.delegate = delegate
    }
    func bestMove(board:[[Int]]) -> AiMove?{
        var board = board
        var bestValue = -99999
        var aiMove:AiMove? = nil
        for row in 0...2 {
            for col in 0...2{
                for layer in 1...3{
                    let mRow = (layer * row) + 3 - layer
                    let mCol = (layer * col) + 3 - layer
                    if board[mRow][mCol] == -1{
                        board[mRow][mCol] = Player.Blue.rawValue
                        let moveValue = miniMax(depth: 2, player: Player.Red, board: board, alpha: minValue, beta: maxValue)
                        board[mRow][mCol] = -1
                        if moveValue > bestValue{
                            bestValue = moveValue
                            aiMove = AiMove(row:row,col:col,layer:layer)
                        }
                        
                    }
                }
            }
        }
        return aiMove
    }
    
    func miniMax(depth:Int,player:Player,board:[[Int]],alpha:Int,beta:Int) ->Int{
        var board = board
        var alpha = alpha
        if depth == 0{
            return self.delegate!.evaluateBoard(board: board)
        }
        if player==Player.Blue {
            var best = minValue
            for row in 0...2 {
                for col in 0...2{
                    for layer in 1...3{
                        let mRow = (layer * row) + 3 - layer
                        let mCol = (layer * col) + 3 - layer
                        if board[mRow][mCol] == -1{
                            board[mRow][mCol] = Player.Blue.rawValue
                            let moveValue = miniMax(depth: depth - 1, player: Player.Red, board: board, alpha: alpha, beta: beta)
                            board[mRow][mCol] = -1
                            best = max(moveValue, best)
                            alpha = max(alpha, best)
                            if beta <= alpha{
                                break
                            }
                        }
                    }
                }
            }
            return best
        }else {
            var best = maxValue
            for row in 0...2 {
                for col in 0...2{
                    for layer in 1...3{
                        let mRow = (layer * row) + 3 - layer
                        let mCol = (layer * col) + 3 - layer
                        if board[mRow][mCol] == -1{
                            board[mRow][mCol] = Player.Red.rawValue
                            let moveValue = miniMax(depth: depth - 1, player: Player.Blue, board: board, alpha: alpha, beta: beta)
                            board[mRow][mCol] = -1
                            best = min(moveValue, best)
                            alpha = min(alpha, best)
                            if beta <= alpha{
                                break
                            }
                        }
                    }
                }
            }
            return best
        }
    }
}
