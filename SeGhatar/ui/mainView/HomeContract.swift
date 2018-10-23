//
//  HomeContract.swift
//  SeGhatar
//
//  Created by MAC on 7/25/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import Foundation
protocol HomeContract {
    func changeColorAt(row: Int, col: Int, layer:Int,playerColor:Player)
    func gameManagerNotSelected()
    func gameIsEnded(title:String,message:String)
    func score(redScore:Int,blueScore:Int)
    func resetTheBoard()
    func showChatBox()
    func hideChatBox()
    func clearChat()
    func toggleGameOption()
    func showOpponentFinder()
    func hideOpponentFinder()
    func newMessageRecived(message:MessageModel)
}
protocol HomePresenterContract {
    func cellTappedAt(row: Int, col: Int, layer:Int)
    func isYourTurn()->Bool
    func twoPlayerSelected()
    func onlineGameSelected()
    func aiGameSelected()
    func resetSelected()
    func sendMessage(msg:String)
    func dispose()
}
