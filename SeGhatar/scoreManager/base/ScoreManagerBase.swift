//
//  ScoreManagerBase.swift
//  SeGhatar
//
//  Created by MAC on 7/25/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import Foundation
protocol BaseDelegate {
    func score(redScore:Int,blueScore:Int)
    func gameIsEnded(redScore:Int,blueScore:Int)
}
class ScoreManagerBase:BaseScoreDelegate {
    func getBoard() -> [[Int]] {
        return self.board
    }
    
    func evaluateBoard(board: [[Int]]) -> Int {
        var aiScore = 0
        var playerScore = 0
        var aiTwo = 0
        var pTwo=0
        for row in 0...6{
            for col in 0...6{
                if board[row][col] == Player.Red.rawValue || board[row][col] == Player.Blue.rawValue {
                    let current = Step(row:row,col:col)
                    for step in allDirections{
                        let res = checkDirection(current: current, step: step,board:board)
                        if res == Player.Blue.rawValue * 3{
                            aiScore += 1
                        }else if res == Player.Red.rawValue * 3 {
                            playerScore += 1
                        }
                        if res == Player.Blue.rawValue * 2{
                            aiTwo += 1
                        }else if res == Player.Red.rawValue * 2 {
                            pTwo += 1
                        }
                    }
                }
            }
        }
        return ((aiScore*600) + (aiTwo * 10)) - ((playerScore * 700) + (pTwo * 10))
    }
    
    func reset() {
        board = [[-1,0,0,-1,0,0,-1],
                  [0,-1,0,-1,0,-1,0],
                  [0,0,-1,-1,-1,0,0],
                  [-1,-1,-1,8,-1,-1,-1],
                  [0,0,-1,-1,-1,0,0],
                  [0,-1,0,-1,0,-1,0],
                  [-1,0,0,-1,0,0,-1],]
        self.redScore = 0
        self.blueScore = 0
        self.delegate?.score(redScore: 0, blueScore: 0)
    }
    
    
    let All_Pieces = 24
    var allDirections : [Step]
    var delegate:BaseDelegate?
    private var redScore = 0
    private var blueScore = 0
    private var board : [[Int]] = [[-1,0,0,-1,0,0,-1],
                                   [0,-1,0,-1,0,-1,0],
                                   [0,0,-1,-1,-1,0,0],
                                   [-1,-1,-1,8,-1,-1,-1],
                                   [0,0,-1,-1,-1,0,0],
                                   [0,-1,0,-1,0,-1,0],
                                   [-1,0,0,-1,0,0,-1],]
    init(directions:[Step],delegate:BaseDelegate) {
        self.allDirections = directions
        self.delegate = delegate
    }
    
    func cellChangeAt(row:Int,col:Int,layer:Int,player:Player){
        self.blueScore = 0
        self.redScore = 0
        let mRow = (layer * row) + 3 - layer
        let mCol = (layer * col) + 3 - layer
        board[mRow][mCol] = player.rawValue
        checkForScore()
    }
    private func isSelected(row:Int,col:Int)->Bool{
        return board[row][col] != 0 && board[row][col] != -1 && board[row][col] != 8
    }
    private func isValid(step:Int)->Bool {
        return step >= 0 && step<7
    }
    private func isPoint(row:Int,col:Int){
        let current:Step = Step(row:row,col:col)
        for step in allDirections {
            let res = checkDirection(current: current, step: step,board:self.board)
            if res == Player.Blue.rawValue * 3{
                self.blueScore += 1
            }else if res == Player.Red.rawValue * 3 {
                self.redScore += 1
            }
        }
    }
    private func checkDirection(current:Step,step:Step,board:[[Int]])->Int{
        var sum = 0
        var testRow = current.row
        var testCol = current.col
        while isValid(step: testRow)&&isValid(step: testCol) {
            let value = board[testRow][testCol]
            if value == 8{
                return sum
            }
            if value != 0 && value != -1{
                sum += value
            }
            testCol += step.col
            testRow += step.row
        }
        
        return sum
    }
    private func checkForScore(){
        var done:Int = 0
        for i in 0...6{
            for j in 0...6{
                if isSelected(row: i, col: j){
                    isPoint(row: i, col: j)
                    done = done + 1
                }
            }
        }
        self.delegate?.score(redScore: redScore, blueScore: blueScore)
        if  done == All_Pieces {
            self.delegate?.gameIsEnded(redScore: redScore, blueScore: blueScore)
        }
    }
}
