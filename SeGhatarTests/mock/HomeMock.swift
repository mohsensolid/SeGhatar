//
//  HomeMock.swift
//  SeGhatarTests
//
//  Created by MAC on 7/28/1397 AP.
//  Copyright © 1397 MohsenSolid. All rights reserved.
//

import Foundation
@testable import SeGhatar
class MockHomeController: HomeContract {
    var changeColorVerify:Bool = false
    var gameMangerNotSelectedVerify:Bool = false
    var gameIsEndVerify:Bool = false
    var scoreVerify:Bool = false
    var resetBoradVerfiy:Bool = false
    var clearChatVerify:Bool = false
    var showChatBoxVerify:Bool = false
    var hideChatBoxVerify:Bool = false
    var toggleGameOptionVerify:Bool = false
    var showOpponentFinderVerify:Bool = false
    var hideOpponentFinderVerify:Bool = false
    var newMessageRecivedVerify:Bool = false
    var row,col,layer,redScore,blueScore:Int?
    var playerColor:Player?
    var title,message:String?
    var messsageModl:MessageModel?
    init() {
        
    }
    func changeColorAt(row: Int, col: Int, layer: Int, playerColor: Player) {
        changeColorVerify = true
        self.row = row
        self.col = col
        self.playerColor = playerColor
        self.layer = layer
    }
    
    func gameManagerNotSelected() {
        gameMangerNotSelectedVerify = true
    }
    
    func gameIsEnded(title: String, message: String) {
        gameIsEndVerify = true
        self.title = title
        self.message = message
    }
    
    func score(redScore: Int, blueScore: Int) {
        scoreVerify = true
        self.redScore  = redScore
        self.blueScore = blueScore
    }
    
    func resetTheBoard() {
        resetBoradVerfiy = true
    }
    
    func showChatBox() {
        showChatBoxVerify = true
    }
    
    func hideChatBox() {
        hideChatBoxVerify = true
    }
    
    func clearChat() {
        clearChatVerify = true
    }
    
    func toggleGameOption() {
        toggleGameOptionVerify = true
    }
    
    func showOpponentFinder() {
        showOpponentFinderVerify = true
    }
    
    func hideOpponentFinder() {
        hideOpponentFinderVerify = true
    }
    
    func newMessageRecived(message: MessageModel) {
        newMessageRecivedVerify = true
        self.messsageModl = message
    }
    
    
}
