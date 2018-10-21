//
//  HomePresenter.swift
//  SeGhatar
//
//  Created by MAC on 7/25/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import Foundation

class HomePresenter : HomePresenterContract {
    
    var scoreManager:ScoreManager?
    var dalegate:HomeContract?
    var gameManager:GameManagerDelegate?
    init(delegate:HomeContract) {
        self.dalegate = delegate
        self.gameManager = nil
        self.scoreManager = DefaultScore(delegate: self)
    }
    func sendMessage(msg: String) {
        if msg != "" {
            gameManager?.sendMessage(message: msg)
        }
    }
    func twoPlayerSelected() {
        reset()
        self.gameManager = LocalGameManager(delegate: self)
        self.dalegate?.hideChatBox()
        self.dalegate?.hideOpponentFinder()
    }
    
    func onlineGameSelected() {
        reset()
        self.dalegate?.showOpponentFinder()
        self.gameManager = OnlineGameManager(delegate: self)
        self.dalegate?.showChatBox()
    }
    
    func aiGameSelected() {
        reset()
        self.gameManager = AiGameManager(delegate: self, scoreManager: self.scoreManager!)
        self.dalegate?.hideChatBox()
        self.dalegate?.hideOpponentFinder()
    }
    
    func resetSelected() {
      reset()
        if self.gameManager != nil{
            self.gameManager?.restart()
        }else{
            self.dalegate?.gameManagerNotSelected()
        }
    }
    private func reset(){
        self.scoreManager?.resetTheGame()
        self.dalegate?.resetTheBoard()
        self.dalegate?.toggleGameOption()
        self.dalegate?.clearChat()
    }
    
    func cellTappedAt(row: Int, col: Int, layer:Int) {
        guard let  manager = gameManager else{
            self.dalegate?.gameManagerNotSelected()
            return
        }
        manager.cellTappedAt(row: row, col: col, layer: layer)
    }
    func isYourTurn() -> Bool {
        guard let  manager = gameManager else{
            return false
        }
        return manager.isYourTurn()
    }
    
}
extension HomePresenter:ScoreDelegate{
    func score(redScore: Int, blueScore: Int) {
        self.dalegate?.score(redScore: redScore, blueScore: blueScore)
    }
    
    func gameIsEnded(redScore:Int,blueScore:Int) {
        var title:String?
        if redScore == blueScore{
            title = "مساوری"
        }else if redScore > blueScore{
            title = "قرمز برنده شد"
        }else{
            title = "ابی برنده شد"
        }
        let message = "ابی = \(blueScore) قرمز = \(redScore)"
        self.dalegate?.gameIsEnded(title:title!,message:message)
    }
    
    
}
extension HomePresenter:GameDelegate{
    func changeItemAt(row: Int, col: Int, layer: Int, player: Player) {
        self.dalegate?.changeColorAt(row: row, col: col, layer: layer, playerColor: player)
        self.scoreManager?.cellChangeAt(row: row, col: col, layer: layer, player: player)
    }
    
    func newMessageRecive(message: String, player: Bool) {
        self.dalegate?.newMessageRecived(message: MessageModel(message:message,sender:player))
    }
    
    func oppnentFinded() {
        self.dalegate?.hideOpponentFinder()
    }
    
    func userDisconnected(player: Player) {
        
    }
}
